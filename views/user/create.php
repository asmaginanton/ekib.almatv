<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;

/* @var $this yii\web\View */
/* @var $model app\models\User */

$this->title = 'Новый пользователь';
$this->params['breadcrumbs'][] = ['label' => 'Пользователи', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="user-create">

    <h1><?= Html::encode($this->title) ?></h1>


    <?php $form = ActiveForm::begin([
        'id' => 'user-form',
        'options' => ['class' => 'form-horizontal'],
        'fieldConfig' => [
            'template' => "{label}\n<div class=\"col-lg-3\">{input}</div>\n<div class=\"col-lg-8\">{error}</div>",
            'labelOptions' => ['class' => 'col-lg-1 control-label'],
        ],
    ]); ?>

<<<<<<< HEAD
        <?= $form->field($model, 'login')->textInput(['autofocus' => true]) ?>
    
        <?= $form->field($model, 'username') ?>
=======
        <?= $form->field($model, 'username')->textInput(['autofocus' => true]) ?>
>>>>>>> b5b3115808a42483038267f8431c60f081807c94
    
        <?= $form->field($model, 'password')->passwordInput() ?>

               <div class="form-group">
            <div class="col-lg-offset-1 col-lg-11">
                <?= Html::submitButton('Создать', ['class' => 'btn btn-primary', 'name' => 'login-button']) ?>
            </div>
        </div>

    <?php ActiveForm::end(); ?>

</div>