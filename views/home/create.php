<?php

use yii\helpers\Html;


/* @var $this yii\web\View */
/* @var $model app\models\Home */

$this->title = 'Новый дом';
$this->params['breadcrumbs'][] = ['label' => 'Список домов', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="home-create">

    <h1><?= Html::encode($this->title) ?></h1>

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>
