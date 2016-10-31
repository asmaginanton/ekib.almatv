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
    private static $_base = array();
    private static $_key;
    private static $_data;

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
    
    private static function getAll(){
        $tmp = Abonent::find()->asArray()
                ->select(['id', 'fullname'])
                ->all();
        
        $result = \yii\helpers\ArrayHelper::index($tmp, 'fullname');
        
        return $result;
    }

    public static function getId($fullname, $mobile, $phone)
    {
        $result = NULL;
        
        if(count(self::$_base) == 0){
            self::$_base = self::getAll();
            self::$_key = Abonent::find()->max('id');
        }
        
        if(array_key_exists($fullname, self::$_base)){
            $result = self::$_base[$fullname];
        } else {
            self::$_key += 1;
            self::$_data[] = ['id' => self::$_key, 'fullname' => $fullname, 'mobile' => $mobile, 'phone' => $phone];
            self::$_base[$fullname] = [self::$_key];
            $result = self::$_key;
        }
        
        return $result;
    }
    
    public static function fetchData()
    {
        \Yii::$app->db->createCommand()
                ->batchInsert('abonent', ['id', 'fullname', 'mobile', 'phone'], self::$_data)
                ->execute();
    }
}
