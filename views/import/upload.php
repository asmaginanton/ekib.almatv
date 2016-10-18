<?php
use yii\bootstrap\ActiveForm;
use yii\helpers\Html;
use yii\models\ImportReport;
use kartik\file\FileInput;
use app\models;

if($model->title){
    $this->title = $model->title;
    
    
 // получение истории импорта   
 $importHistores = models\ImportResult::find()->
         where(['type' => $model->getShortClassName()])->
         orderBy(['date' => SORT_DESC])->limit(3)->
         all();
 $counter = 1;
}

$this->params['breadcrumbs'][] = $this->title;?>
<div class="row">
    <div class="col-md-7">
        <h1><?= Html::encode($this->title) ?></h1>
    </div>
    <div class="col-md-5">
        <div class="panel panel-info">
            <div class="panel-heading">
                <h4 class="panel-title">История импорта:</h4>
            </div>
            <div class="panel-body">
                <table class=" table table-condensed" style="margin-bottom: 0px;">
                    <?php foreach ($importHistores as $importHistory): ?>
                    <tr>
                        <td><?= $counter; $counter++ ?></td>
                        <td><?= $importHistory->dateText ?></td>
                        <td><?= $importHistory->executor?></td>
                        <td><?= $importHistory->status?></td>
                    </tr>
                    <?php endforeach;?>
                </table>
            </div>
        </div>
    </div>
</div>


<?php 
$form = ActiveForm::begin(
        ['options' => ['enctype' => 'multipart/form-data']
]); 

echo $form->field($model, 'csvFile')->widget(FileInput::className(),[
        'model' => $model,
        'attribute' => 'csvFile',
        
        'pluginOptions' => [
            'showPreview' => FALSE, 
            'showRemove' => FALSE,
            'initialCaption' => 'Выбирете файл для загрузки',
            'allowedFileTypes' => ['text'],
            'msgInvalidFileType' => 'Не верный тип файла "{name}". Для загрузки необходим файл типа "{types}".',
            'allowedFileExtensions' => ['csv'],
            ]])->label(FALSE); ?>

<!--<div class="form-group">
    <div>
        <?= Html::submitButton('Загрузить', ['class' => 'btn btn-primary', 'name' => 'upload-button']) ?>
    </div>
</div>-->

<?php ActiveForm::end() ?>

<?php if($model->isResult()): ?>

<div class="alert <?= 'alert-'.$model->getImportStatus(); ?>">
    <?= Html::label('Обработано: '.$model->isResult().' строк. '.'Результат: '.$model->getImportStatus()); ?>
</div>    

<?php
$successes = $model->getSuccesses();
$warnings = $model->getWarnings();
$errors = $model->getErrors();
?>

    <?php if(count($successes)>0): ?>
    <div class="alert alert-success">
        <div class="panel-heading">
            <h4 class="panel-title">
                <a data-toggle="collapse" href="#successes">
                    <?= "Successes (".  count($successes).")" ;?>
                </a>
            </h4>
        
            <div id="successes" class="collapse panel-body">
                <?php foreach ($successes as $success): ?> 
                        <?php foreach ($success as $key => $value): ?>
                            <?= "<p>{$key} => {$value}</p>"; ?>
                        <?php endforeach; ?>
                <?php endforeach; ?>
            </div>
        </div>
    </div>    
    <?php    endif; ?>
    
    <?php if(count($warnings)>0): ?>
    <div class="alert alert-warning">
        <div class="panel-heading">
            <h4 class="panel-title">
                <a data-toggle="collapse" data-parrent="#accordion" href="#warnings">
                    <?= "Warnings (".  count($warnings).")" ;?>
                </a>
            </h4>

            <div id="warnings" class="collapse panel-body">
                <?php foreach ($warnings as $warning): ?> 
                        <?php foreach ($warning as $key => $value): ?>
                            <?= "<p>{$key} => {$value}</p>"; ?>
                        <?php endforeach; ?>
                <?php endforeach; ?>
            </div>
        </div>
    </div>
    <?php    endif; ?>

<?php endif; ?>

<button type="button" class="btn btn-danger" data-toggle="collapse" data-target="#dump">
  Dump Results
</button>

<div id="dump" class="collapse">
    <?=        yii\helpers\VarDumper::dump(models\MyProfiler::getResult(), 10, TRUE); ?>
</div>
