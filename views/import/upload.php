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

<?php if($model->isResult()): ?>

<div class="alert <?= 'alert-'.$model->getImportStatus(); ?>">
    <?= Html::label('Обработано: '.$model->isResult().' строк. '.'Результат: '.$model->getImportStatus()); ?>
</div>    

<?php
$successes = $model->getSuccesses();

?>

    <?php if($model->getWarnings()): ?>
    <?php foreach ()

    <?php    endif; ?>

<button type="button" class="btn btn-danger" data-toggle="collapse" data-target="#dump">
  Dump Results
</button>

<div id="dump" class="collapse in">
    <?=        yii\helpers\VarDumper::dump($model->getResult(), 10, TRUE); ?>
</div>

<?php endif; ?>

<!--<div style="display: inline">
<?php //yii\helpers\VarDumper::dump($model->arrayData, 10, TRUE) ?>
</div>-->
