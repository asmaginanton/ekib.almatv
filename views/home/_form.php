<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;

/* @var $this yii\web\View */
/* @var $model app\models\Home */
/* @var $form yii\widgets\ActiveForm */
?>

<div class="home-form">

    <?php $form = ActiveForm::begin(); ?>

    <?= $form->field($model, 'street_id')->dropDownList($model->streets)->label('Улица:') ?>

    <?= $form->field($model, 'number')->textInput()->label('Номер дома:') ?>

    <?= $form->field($model, 'korpus')->textInput(['maxlength' => true])->label('Корпус:') ?>

    <?= $form->field($model, 'agent_id')->dropDownList($model->agents)->label('Агент:') ?>

    <?= $form->field($model, 'district_id')->dropDownList($model->districts)->label('Район:') ?>

    <?= $form->field($model, 'apartments')->textInput() ?>

    <?= $form->field($model, 'number_of_storeys')->textInput() ?>

    <?= $form->field($model, 'number_of_entrances')->textInput() ?>

    <?= $form->field($model, 'apartments_pattern')->textInput(['maxlength' => true]) ?>

    <div class="form-group">
        <?= Html::submitButton($model->isNewRecord ? 'Создать' : 'Сохранить', ['class' => $model->isNewRecord ? 'btn btn-success' : 'btn btn-primary']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>
