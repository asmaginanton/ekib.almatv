<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace app\controllers;

use Yii;
use yii\web\Controller;
use app\models\ExtendAbonentsReport;
use yii\web\UploadedFile;

/**
 * Description of ImportController
 *
 * @author anton.smagin
 */
class ImportController extends Controller{
    
    public function actionExtendAbonentsReport(){
        
        $model = new ExtendAbonentsReport();
        
        if(Yii::$app->request->isPost){
            $model->csvFile = UploadedFile::getInstance($model, 'csvFile');
            if ($model->upload()) {
                
            }
        }
        
        return $this->render('upload',['model' => $model]);
        
    }
    
}
