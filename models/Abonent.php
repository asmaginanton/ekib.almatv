<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "abonent".
 *
 * @property integer $id
 * @property string $fullname
 * @property string $mobile
 * @property integer $address_id
 * @property integer $contract_id
 */
class Abonent extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'abonent';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['fullname', 'address_id', 'contract_id'], 'required'],
            [['address_id', 'contract_id'], 'integer'],
            [['fullname'], 'string', 'max' => 255],
            [['mobile'], 'string', 'max' => 12],
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'fullname' => 'Fullname',
            'mobile' => 'Mobile',
            'address_id' => 'Address ID',
            'contract_id' => 'Contract ID',
        ];
    }
    

}
