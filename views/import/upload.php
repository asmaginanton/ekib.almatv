<?php
use yii\widgets\ActiveForm;
use yii\helpers\Html;
?>

<?php $form = ActiveForm::begin(
        ['id' => 'upload-form'],
        ['options' => ['enctype' => 'multipart/form-data']]
        ); 
?>

<?= $form->field($model, 'csvFile')->fileInput(['class' => 'btn']); ?>

<div class="form-group">
    <div class="col-lg-11">
        <?= Html::submitButton('Загрузить', ['class' => 'btn btn-primary', 'name' => 'upload-button']) ?>
    </div>
</div>

<?php ActiveForm::end() ?>

<div style="display: inline-block">
<?php var_dump($model->csvFile) ?>
<?php var_dump($model->arrayData) ?>
</div>
