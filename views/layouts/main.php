<?php

/* @var $this \yii\web\View */
/* @var $content string */

use yii\helpers\Html;
use yii\bootstrap\Nav;
use yii\bootstrap\NavBar;
use yii\widgets\Breadcrumbs;
use app\assets\AppAsset;

AppAsset::register($this);
?>
<?php $this->beginPage() ?>
<!DOCTYPE html>
<html lang="<?= Yii::$app->language ?>">
<head>
    <meta charset="<?= Yii::$app->charset ?>">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <?= Html::csrfMetaTags() ?>
    <title><?= Html::encode($this->title) ?></title>
    <?php $this->head() ?>
</head>
<body>
<?php $this->beginBody() ?>

<div class="wrap">
    <?php
    NavBar::begin([
        'brandLabel' => 'ALMA-TV comunications',
        'brandUrl' => Yii::$app->homeUrl,
        'options' => [
            'class' => 'navbar-inverse navbar-fixed-top',
        ],
    ]);
    
  
    if (Yii::$app->user->can('admin')) {
        $items[] = ['label' => 'Администрирование', 
                'items' => [
                ['label' => 'Пользователи', 'url' => ['/user']],
                ['label' => 'Управление ролями', 'url' => ['/permit/access/role']],
                ['label' => 'Управление правами доступа', 'url' => ['/permit/access/permission']],
            ]];
    }
    
    if(! Yii::$app->user->isGuest){
        $items[] = ['label' => 'Справочники', 
                        'items' => [
                            ['label' => 'Агенты', 'url' => '/agent/index'],
                            ['label' => 'Улицы', 'url' => '/street/index'],
                        ]];
    }
    
    Yii::$app->user->isGuest ? (
        $items[] = ['label' => 'Вход', 'url' => ['/site/login']]
        ) : (
        $items[] = '<li>'
            . Html::beginForm(['/site/logout'], 'post', ['class' => 'navbar-form'])
            . Html::submitButton(
            'Выход (' . Yii::$app->user->identity->username . ')',
            ['class' => 'btn btn-link']
            )
            . Html::endForm()
            . '</li>'
    );
    
    echo Nav::widget([
        'options' => ['class' => 'navbar-nav navbar-right'],
        'items' => $items
    ]);
    
    NavBar::end();
    ?>

    <div class="container">
        <?= Breadcrumbs::widget([
            'links' => isset($this->params['breadcrumbs']) ? $this->params['breadcrumbs'] : [],
        ]) ?>
        <?= $content ?>
    </div>
</div>

<footer class="footer">
    <div class="container">
        <p class="pull-left">&copy; asmagin <?= date('Y') ?></p>

        <p class="pull-right"><?= Yii::powered() ?></p>
    </div>
</footer>

<?php $this->endBody() ?>
</body>
</html>
<?php $this->endPage() ?>
