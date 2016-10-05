<?php

use yii\helpers;

use yii\widgets\ActiveForm;
use kartik\file\FileInput;

$form = ActiveForm::begin([
    'options'=>['enctype'=>'multipart/form-data'] // important
]);
echo $form->field($model, 'filename');

// your fileinput widget for single file upload
echo $form->field($model, 'image')->widget(FileInput::classname(), [
    'options'=>['accept'=>'image/*'],
    'pluginOptions'=>['allowedFileExtensions'=>['jpg','gif','png']]
]);

/**
* uncomment for multiple file upload
*
echo $form->field($model, 'image[]')->widget(FileInput::classname(), [
    'options'=>['accept'=>'image/*', 'multiple'=>true],
    'pluginOptions'=>['allowedFileExtensions'=>['jpg','gif','png']
]);
*
*/
echo helpers\Html::submitButton('Upload', [
    'class'=> 'btn btn-success' ]
);
ActiveForm::end();


?>
