<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace app\models;

use Yii;
use yii\base;

/**
 * Description of DatabaseBackup
 *
 * @author anton.smagin
 */
class DatabaseBackup {
    
    private $file;
    private $file_name;
    private $backup_path;
    static private $_instance;
    
    private function __construct() {

    }
    
    private static function getInstanse(){
        
        if(is_null(self::$_instance)){
            self::$_instance = new self();
        }
        return self::$_instance;
    }

    public static function Backup($sender, $tables = NULL){
        
        $span_backup = MyProfiler::Start();
        
        $instanse = self::getInstanse();
        
        if($tables === NULL){
            $tables = $instanse->getTables();
        } else {
            (is_array($tables)) ? : ($tables = split(",", $tables));
        }
        
        if(!is_array($tables)){
            throw new Exception ("Wrong input data");}
        
        if (!$instanse->fileOpen($sender)){
            throw new base\ErrorException("Error open file " . $instanse->file_name);
        }
            
        if (! $instanse->StartBackup ()) {
            throw new Exception("Error start backup");
        }

        foreach ( $tables as $tableName ) {
                $instanse->getColumns ( $tableName );
        }
        foreach ( $tables as $tableName ) {
                $instanse->getData ( $tableName );
        }

        $instanse->EndBackup (); 
        
        $span_backup->Stop("Backup");
    }
    
    private function fileOpen($sender){
        
        // Получаем имя модели вызвавшей функцию
        $class = new \ReflectionClass($sender);
        $model_name = $class->getShortName();
        // Формируем путь для сохранения бэкапа
        $this->backup_path =    \Yii::$app->basePath . 
                                \Yii::$app->params['backupPath'] .
                                $model_name . '\\';
        if(!file_exists($this->backup_path)){
            mkdir($this->backup_path, 0777, TRUE);
        }
        // Формируем имя файла
        $this->file_name = $this->backup_path . 'backup_' . date( 'Y.m.d_H.i.s' ) . '.sql';
        
        try{
            $this->file = fopen ( $this->file_name, 'w+' );
            return TRUE;
        } catch (Exception $ex) {
                    return FALSE;
        }
    }

    private function getTables() {
            $sql = 'SHOW TABLES';
            $cmd = Yii::$app->db->createCommand ( $sql );
            $tables = $cmd->queryColumn ();
            return $tables;
    }
    
    private function StartBackup($addcheck = true) {
            

            if ($this->file == null)
                    return false;
            fwrite ( $this->file, '-- -------------------------------------------' . PHP_EOL );
            if ($addcheck) {
                    fwrite ( $this->file, 'SET AUTOCOMMIT=0;' . PHP_EOL );
                    fwrite ( $this->file, 'START TRANSACTION;' . PHP_EOL );
                    fwrite ( $this->file, 'SET SQL_QUOTE_SHOW_CREATE = 1;' . PHP_EOL );
            }
            fwrite ( $this->file, 'SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;' . PHP_EOL );
            fwrite ( $this->file, 'SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;' . PHP_EOL );
            fwrite ( $this->file, '-- -------------------------------------------' . PHP_EOL );
            $this->writeComment ( 'START BACKUP' );
            return true;
    }
    
    private function EndBackup($addcheck = true) {
            fwrite ( $this->file, '-- -------------------------------------------' . PHP_EOL );
            fwrite ( $this->file, 'SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;' . PHP_EOL );
            fwrite ( $this->file, 'SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;' . PHP_EOL );

            if ($addcheck) {
                    fwrite ( $this->file, 'COMMIT;' . PHP_EOL );
            }
            fwrite ( $this->file, '-- -------------------------------------------' . PHP_EOL );
            $this->writeComment ( 'END BACKUP' );
            fclose ( $this->file );
            $this->file = null;
//            if ($this->enableZip) {
//                    $this->createZipBackup ();
//            }
    }
    
    private function getColumns($tableName) {
        $sql = 'SHOW CREATE TABLE ' . $tableName;
        $cmd = \Yii::$app->db->createCommand ( $sql );
        $table = $cmd->queryOne ();

        $create_query = $table ['Create Table'] . ';';

        $create_query = preg_replace ( '/^CREATE TABLE/', 'CREATE TABLE IF NOT EXISTS', $create_query );
        $create_query = preg_replace ( '/AUTO_INCREMENT\s*=\s*([0-9])+/', '', $create_query );
        if ($this->file) {
                $this->writeComment ( 'TABLE `' . addslashes ( $tableName ) . '`' );
                $final = 'DROP TABLE IF EXISTS `' . addslashes ( $tableName ) . '`;' . PHP_EOL . $create_query . PHP_EOL . PHP_EOL;
                fwrite ( $this->file, $final );
        } 
        // не понятно для чего ---------------------------------------------------
//        else {
//                $this->tables [$tableName] ['create'] = $create_query;
//                return $create_query;
//        }
    }
    
    private function getData($tableName) {
        $sql = 'SELECT * FROM ' . $tableName;
        $cmd = \Yii::$app->db->createCommand ( $sql );
        $dataReader = $cmd->query ();

        if ($this->file) {
                $this->writeComment ( 'TABLE DATA ' . $tableName );
        }

        foreach ( $dataReader as $data ) {
                $data_string = '';
                $itemNames = array_keys ( $data );
                $itemNames = array_map ( "addslashes", $itemNames );
                $items = join ( '`,`', $itemNames );
                $itemValues = array_values ( $data );
                $itemValues = array_map ( "addslashes", $itemValues );
                $valueString = join ( "','", $itemValues );
                $valueString = "('" . $valueString . "'),";
                $values = "\n" . $valueString;
                if ($values != "") {
                        $data_string .= "INSERT INTO `$tableName` (`$items`) VALUES" . rtrim ( $values, "," ) . ";;;" . PHP_EOL;
                }
                if ($this->file) {
                        fwrite ( $this->file, $data_string );
                }
        }

        if ($this->file) {
                $this->writeComment ( 'TABLE DATA ' . $tableName );
                $final = PHP_EOL . PHP_EOL . PHP_EOL;
                fwrite ( $this->file, $final );
        }
    }
    
    public function writeComment($string) {
        fwrite ( $this->file, '-- -------------------------------------------' . PHP_EOL );
        fwrite ( $this->file, '-- ' . $string . PHP_EOL );
        fwrite ( $this->file, '-- -------------------------------------------' . PHP_EOL );
    }
    
    
//    	public $menu = [ ];
//	public $tables = [ ];
//	public $fp;
//	public $file_name;
//	public $enableZip = true;
//	public $_path = null;
//	public $back_temp_file = 'db_backup_';
//	// public $layout = '//layout2';
//	public function getModule() {
//		return $this->module;
//	}
//	protected function getPath() {
//		if (isset ( $this->module->path ))
//			$this->_path = $this->module->path;
//		else
//			$this->_path = Yii::$app->basePath . '/_backup/';
//		
//		if (! file_exists ( $this->_path )) {
//			mkdir ( $this->_path );
//			chmod ( $this->_path, '777' );
//		}
//		return $this->_path;
//	}
//        
//	public function execSqlFile($sqlFile) {
//		$message = "ok";
//		
//		if (file_exists ( $sqlFile )) {
//			$sqlArray = file_get_contents ( $sqlFile );
//			
//			$cmd = Yii::$app->db->createCommand ( $sqlArray );
//			try {
//				$cmd->execute ();
//			} catch ( Exception $e ) {
//				$message = $e->getMessage ();
//			}
//		}
//		return $message;
//	}
//        
//	
//
//
//        
//
//
//	public function actionCreate() {
//		$tables = $this->getTables ();
////		if (! $this->StartBackup ()) {
////			
////			// render error
////			Yii::$app->user->setFlash ( 'success', "Error" );
////			return $this->render ( 'index' );
////		}
////		
////		foreach ( $tables as $tableName ) {
////			$this->getColumns ( $tableName );
////		}
////		foreach ( $tables as $tableName ) {
////			$this->getData ( $tableName );
////		}
////		
////		$this->EndBackup ();
//		
//		$this->redirect ( array (
//				'index' 
//		) );
//	}
//	public function actionClean($redirect = true) {
//		$ignore = array (
//				'tbl_user',
//				'tbl_user_role',
//				'tbl_event' 
//		);
//		$tables = $this->getTables ();
//		
//		if (! $this->StartBackup ()) {
//			// render error
//			Yii::$app->user->setFlash ( 'success', "Error" );
//			return $this->render ( 'index' );
//		}
//		
//		$message = '';
//		
//		foreach ( $tables as $tableName ) {
//			if (in_array ( $tableName, $ignore ))
//				continue;
//			fwrite ( $this->fp, '-- -------------------------------------------' . PHP_EOL );
//			fwrite ( $this->fp, 'DROP TABLE IF EXISTS ' . addslashes ( $tableName ) . ';' . PHP_EOL );
//			fwrite ( $this->fp, '-- -------------------------------------------' . PHP_EOL );
//			
//			$message .= $tableName . ',';
//		}
//		$this->EndBackup ();
//		
//		// logout so there is no problme later .
//		Yii::$app->user->logout ();
//		
//		$this->execSqlFile ( $this->file_name );
//		unlink ( $this->file_name );
//		$message .= ' are deleted.';
//		Yii::$app->session->setFlash ( 'success', $message );
//		return $this->redirect ( array (
//				'index' 
//		) );
//	}
//	public function actionDelete($id) {
//		$list = $this->getFileList ();
//		$list = array_merge ( $list, $this->getFileList ( '*.zip' ) );
//		$list = array_reverse($list);
//		$file = $list [$id];
//		$this->updateMenuItems ();
//		if (isset ( $file )) {
//			$sqlFile = $this->path . basename ( $file );
//			if (file_exists ( $sqlFile ))
//				unlink ( $sqlFile );
//		} else
//			throw new HttpException ( 404, Yii::t ( 'app', 'File not found' ) );
//		return $this->redirect(['index']);
//	}
//	public function actionDownload($file = null) {
//		$this->updateMenuItems ();
//		if (isset ( $file )) {
//			$sqlFile = $this->path . basename ( $file );
//			if (file_exists ( $sqlFile )) {
//				$request = Yii::$app->getRequest ();
//				$request->sendFile ( basename ( $sqlFile ), file_get_contents ( $sqlFile ) );
//			}
//		}
//		throw new HttpException ( 404, Yii::t ( 'app', 'File not found' ) );
//	}
//	protected function getFileList($ext = '*.sql') {
//		$path = $this->path;
//		$dataArray = array ();
//		$list = array ();
//		$list_files = glob ( $path . $ext );
//		if ($list_files) {
//			$list = array_map ( 'basename', $list_files );
//			sort ( $list );
//		}
//		return $list;
//	}
//	public function actionIndex() {
//		// $this->layout = 'column1';
//		$this->updateMenuItems ();
//		
//		$list = $this->getFileList ();
//		$list = array_merge ( $list, $this->getFileList ( '*.zip' ) );
//		$dataArray = [ ];
//		foreach ( $list as $id => $filename ) {
//			$columns = array ();
//			$columns ['id'] = $id;
//			$columns ['name'] = basename ( $filename );
//			$columns ['size'] = filesize ( $this->path . $filename );
//			
//			$columns ['create_time'] = date ( 'Y-m-d H:i:s', filectime ( $this->path . $filename ) );
//			$columns ['modified_time'] = date ( 'Y-m-d H:i:s', filemtime ( $this->path . $filename ) );
//			if (date ( 'M-d-Y' . ' \a\t ' . ' g:i A', filemtime ( $this->path . $filename ) ) > date ( 'M-d-Y' . ' \a\t ' . ' g:i A', filectime ( $this->path . $filename ) )) {
//				$columns ['modified_time'] = date ( 'M-d-Y' . ' \a\t ' . ' g:i A', filemtime ( $this->path . $filename ) );
//			}
//			
//			$dataArray [] = $columns;
//		}
//		
//		$dataProvider = new ArrayDataProvider ( [ 
//				'allModels' => array_reverse ( $dataArray ),
//				'sort' => [ 
//						'attributes' => [ 
//								'modified_time' => SORT_ASC 
//						] 
//				] 
//		] );
//		
//		return $this->render ( 'index', array (
//				'dataProvider' => $dataProvider 
//		) );
//	}
//	public function actionRestore($filename) {
//		$this->updateMenuItems ();
//		$message = 'OK. Done';
//		$sqlZipFile = $this->path . basename ( $filename );
//		$sqlFile = $this->unzip ( $sqlZipFile );
//		$status = $this->execSqlFile ( $sqlFile );
//		if ($status) {
//			Yii::$app->session->setFlash ( 'success', Yii::t ( 'app', 'Backup restored successfully.' ) );
//			return $this->redirect ( [ 
//					'index' 
//			] );
//		} else {
//			Yii::$app->session->setFlash ( 'error', Yii::t ( 'app', 'Error while restoring the backup.' ) );
//		}
//		return $this->render ( 'restore', array (
//				'error' => $message 
//		) );
//	}
//	public function actionUpload() {
//		$model = new UploadForm ();
//		if (isset ( $_POST ['UploadForm'] )) {
//			$model->attributes = $_POST ['UploadForm'];
//			$model->upload_file = \yii\web\UploadedFile::getInstance ( $model, 'upload_file' );
//			if ($model->upload_file->saveAs ( $this->path . $model->upload_file )) {
//				// redirect to success page
//				return $this->redirect ( array (
//						'index' 
//				) );
//			}
//		}
//		
//		return $this->render ( 'upload', array (
//				'model' => $model 
//		) );
//	}
//	
//	/**
//	 * Charge method to backup and create a zip with this
//	 */
//	private function createZipBackup() {
//		$zip = new \ZipArchive ();
//		$file_name = $this->file_name . '.zip';
//		if ($zip->open ( $file_name, \ZipArchive::CREATE ) === TRUE) {
//			$zip->addFile ( $this->file_name, basename ( $this->file_name ) );
//			$zip->close ();
//			
//			@unlink ( $this->file_name );
//		}
//	}
//	
//	/**
//	 * Method responsible for reading a directory and add them to the zip
//	 *
//	 * @param ZipArchive $zip        	
//	 * @param string $alias        	
//	 * @param string $directory        	
//	 */
//	private function zipDirectory($zip, $alias, $directory) {
//		if ($handle = opendir ( $directory )) {
//			while ( ($file = readdir ( $handle )) !== false ) {
//				if (is_dir ( $directory . $file ) && $file != "." && $file != ".." && ! in_array ( $directory . $file . '/', $this->module->excludeDirectoryBackup ))
//					$this->zipDirectory ( $zip, $alias . $file . '/', $directory . $file . '/' );
//				
//				if (is_file ( $directory . $file ) && ! in_array ( $directory . $file, $this->module->excludeFileBackup ))
//					$zip->addFile ( $directory . $file, $alias . $file );
//			}
//			closedir ( $handle );
//		}
//	}
//	/**
//	 * Zip file execution
//	 *
//	 * @param string $zipFile
//	 *        	Name of file zip
//	 */
//	private function unzip($sqlZipFile) {
//		if (file_exists ( $sqlZipFile )) {
//			$zip = new \ZipArchive ();
//			if ($zip->open ( $sqlZipFile )) {
//				$zip->extractTo ( dirname ( $sqlZipFile ) );
//				$zip->close ();
//				$sqlZipFile = str_replace ( ".zip", "", $sqlZipFile );
//			}
//		}
//		return $sqlZipFile;
//	}
//	protected function updateMenuItems($model = null) {
//		// create static model if model is null
//		if ($model == null)
//			$model = new UploadForm ();
//		
//		switch ($this->action->id) {
//			case 'restore' :
//				{
//					$this->menu [] = array (
//							'label' => Yii::t ( 'app', 'View Site' ),
//							'url' => Yii::$app->HomeUrl 
//					);
//				}
//			case 'create' :
//				{
//					$this->menu [] = array (
//							'label' => Yii::t ( 'app', 'List Backup' ),
//							'url' => array (
//									'index' 
//							) 
//					);
//				}
//				break;
//			case 'upload' :
//				{
//					$this->menu [] = array (
//							'label' => Yii::t ( 'app', 'Create Backup' ),
//							'url' => array (
//									'create' 
//							) 
//					);
//				}
//				break;
//			default :
//				{
//					$this->menu [] = array (
//							'label' => Yii::t ( 'app', 'List Backup' ),
//							'url' => array (
//									'index' 
//							) 
//					);
//					$this->menu [] = array (
//							'label' => Yii::t ( 'app', 'Create Backup' ),
//							'url' => array (
//									'create' 
//							) 
//					);
//					$this->menu [] = array (
//							'label' => Yii::t ( 'app', 'Upload Backup' ),
//							'url' => array (
//									'upload' 
//							) 
//					);
//					// $this->menu[] = array('label'=>Yii::t('app', 'Restore Backup') , 'url'=>array('restore'));
//					$this->menu [] = array (
//							'label' => Yii::t ( 'app', 'Clean Database' ),
//							'url' => array (
//									'clean' 
//							) 
//					);
//					$this->menu [] = array (
//							'label' => Yii::t ( 'app', 'View Site' ),
//							'url' => Yii::$app->HomeUrl 
//					);
//				}
//				break;
//		}
//	}
    
}
