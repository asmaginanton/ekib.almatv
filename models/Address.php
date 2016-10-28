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
    private static $_addresses = array();
    private static $_key = 0;
    private static $_data = array();

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
            [['home_id'], 'required'],
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
    
    private static function getAll(){
        
        $tmp = Address::findBySql('SELECT concat(home_id, "000",apartment) as haid, `id` FROM `address` ORDER BY haid')
                ->asArray()
                ->all();
        
        $result = \yii\helpers\ArrayHelper::index($tmp, 'haid');
        
        return $result;
    }

    public static function getId($home_id, $apartment){
        
        $result = NULL;
        
        if(count(self::$_addresses) == 0){
            self::$_addresses = self::getAll();
            self::$_key = Address::find()->max('id');
        }
        
        $findkey = $home_id . "000" . $apartment;
        
        if(array_key_exists($findkey, self::$_addresses)){
            $result = self::$_addresses[$findkey];
        } else {
            self::$_key += 1;
            self::$_data[] = ['id' => self::$_key, 'home_id' => $home_id, 'apartment' => $apartment];
            self::$_addresses[$findkey] = [self::$_key];
            $result = self::$_key;
        }
        
        return $result;
    }
    
    public static function fetchData()
    {
        \Yii::$app->db->createCommand()->batchInsert('address', ['id', 'home_id', 'apartment'], self::$_data)->execute();
    }
}