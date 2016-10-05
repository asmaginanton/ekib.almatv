<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace app\controllers;

use yii\web;
use yii\web\UploadedFile;
use app\models;

/**
 * Description of TestController
 *
 * @author anton.smagin
 */
class TestController extends web\Controller{
    
    public function actionUpload()
    {
        $model = new models\Mfileupload();
        if($model->load(\Yii::$app->request->post())){
            
            $image = UploadedFile::getInstance($model, 'image');
            
            $model->filename = $image->name;
            $ext = end((explode(".", $image->name)));
            
            $model->avatar = "avatatr.{$ext}";
            $path = \Yii::$app->basePath."\\uploads\\".$model->avatar;
            
                $image->saveAs($path);
                
        }
        return $this->render('upload',['model' => $model]);
    }
    
}
