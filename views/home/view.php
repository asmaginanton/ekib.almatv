<?php

use yii\helpers\Html;
use yii\widgets\DetailView;

/* @var $this yii\web\View */
/* @var $model app\models\Home */

$this->title = $model->fullname;
$this->params['breadcrumbs'][] = ['label' => 'Список домов', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="home-view">

    <h1><?= Html::encode($this->title) ?></h1>

    <p>
        <?= Html::a('Редактировать', ['update', 'id' => $model->id], ['class' => 'btn btn-primary']) ?>
        <?= Html::a('Удалить', ['delete', 'id' => $model->id], [
            'class' => 'btn btn-danger',
            'data' => [
                'confirm' => 'Are you sure you want to delete this item?',
                'method' => 'post',
            ],
        ]) ?>
    </p>

    <?= DetailView::widget([
        'model' => $model,
        'attributes' => [
            
            'street.name',
            'number',
            'korpus',
            'agent.name',
            'district.name',
            'apartments',
            'number_of_storeys',
            'number_of_entrances',
            'apartments_pattern',
        ],
    ]) ?>

</div>
