<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "address".
 *
 * @property integer $id
 * @property integer $home_id
 * @property string $apartment
 */
class Address extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'address';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['home_id', 'apartment'], 'required'],
            [['home_id'], 'integer'],
            [['apartment'], 'string', 'max' => 3],
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'home_id' => 'Home ID',
            'apartment' => 'Apartment',
        ];
    }
    
    public function getId($home, $apartment)
    {
        $home_id = Home::getIdByFullname($home);
        if(!$home_id){
            return NULL;
        }
        
        $address = Address::find()->where(['home_id' => $home_id, 'apartment' => $apartment])->one();
        if(!$address){
            $address = new Address();
            $address->home_id = $home_id;
            $address->apartment = $apartment;
            if($address->validate()) {
                $address->save();
                Comment::WriteComment('address', $address->id, 'Внесен в базу данных');
            }
        }
        return $address->id;
    }
}
