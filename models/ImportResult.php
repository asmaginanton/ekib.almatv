<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "import_result".
 *
 * @property integer $id
 * @property string $type
 * @property string $date
 * @property string $status
 * @property string $executor
 * @property string $descr
 */
class ImportResult extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'import_result';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['type', 'date', 'status', 'executor', 'descr'], 'required'],
            [['date'], 'safe'],
            [['type'], 'string', 'max' => 30],
            [['status'], 'string', 'max' => 10],
            [['executor', 'descr'], 'string', 'max' => 100],
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'type' => 'Type',
            'date' => 'Date',
            'status' => 'Status',
            'executor' => 'Executor',
            'descr' => 'Descr',
        ];
    }
}
