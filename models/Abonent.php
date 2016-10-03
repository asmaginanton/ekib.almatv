<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "abonent".
 *
 * @property integer $id
 * @property string $fullname
 * @property string $mobile
 * @property string $phone
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
            [['fullname'], 'required'],
            [['fullname', 'mobile', 'phone'], 'string', 'max' => 255],
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
            'phone' => 'Телефон',
        ];
    }
    

}
