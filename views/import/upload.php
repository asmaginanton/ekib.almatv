<?php
use yii\bootstrap\ActiveForm;
use yii\helpers\Html;
use yii\models\ImportReport;

if($model->title){
    $this->title = $model->title;
}

?>

<div class="upload-form">
<?php $form = ActiveForm::begin(
        ['id' => 'upload-form'],
        ['options' => ['enctype' => 'multipart/form-data']]
        ); 
?>

<?= $form->field($model, 'csvFile')->fileInput(['class' => 'file', 'type' => 'file']); ?>

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

<!--<button type="button" class="btn btn-danger" data-toggle="collapse" data-target="#dump">
  Dump Results
</button>

<div id="dump" class="collapse">
    <?=        yii\helpers\VarDumper::dump($model->getResult(), 10, TRUE); ?>
</div>-->

<?php endif; ?>
