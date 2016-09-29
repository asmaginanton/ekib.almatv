<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "contract".
 *
 * @property integer $id
 * @property integer $number
 * @property string $category
 * @property string $status
 * @property string $balance
 * @property string $type
 * @property integer $abonent_id
 * @property integer $address_id
 */
class Contract extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'contract';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['number', 'category', 'status', 'balance', 'type', 'abonent_id', 'address_id'], 'required'],
            [['number', 'abonent_id', 'address_id'], 'integer'],
            [['balance'], 'number'],
            [['category'], 'string', 'max' => 3],
            [['status'], 'string', 'max' => 1],
            [['type'], 'string', 'max' => 30],
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'number' => 'Number',
            'category' => 'Category',
            'status' => 'Status',
            'balance' => 'Balance',
            'type' => 'Type',
            'abonent_id' => 'Abonent ID',
            'address_id' => 'Address ID',
        ];
    }
    
    public function checkState($number, $category, $status, $balance, $type){
        return TRUE;
    }
}
