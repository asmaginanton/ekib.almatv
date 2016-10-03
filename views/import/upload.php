<?php
use yii\widgets\ActiveForm;
use yii\helpers\Html;
?>

<div class="upload-form">
<?php $form = ActiveForm::begin(
        ['id' => 'upload-form'],
        ['options' => ['enctype' => 'multipart/form-data']]
        ); 
?>

<?= $form->field($model, 'csvFile')->fileInput(['class' => 'btn']); ?>

<div class="form-group">
    <div>
        <?= Html::submitButton('Загрузить', ['class' => 'btn btn-primary', 'name' => 'upload-button']) ?>
    </div>
</div>

<?php ActiveForm::end() ?>
</div>


<div class="alert <?= ($model->getImportStatus()=='успешный') ? 'alert-success' : 'alert-danger'; ?>">
    <?= Html::label('Результат импорта: '.$model->getImportStatus()); ?>
    <?=        yii\helpers\VarDumper::dump($model->getResult(), 10, TRUE); ?>
</div>


<!--<div style="display: inline">
<?php //yii\helpers\VarDumper::dump($model->arrayData, 10, TRUE) ?>
</div>-->
