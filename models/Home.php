<?php

namespace app\models;

use Yii;
use yii\helpers;

/**
 * This is the model class for table "home".
 *
 * @property integer $id
 * @property integer $street_id
 * @property integer $number
 * @property string $korpus
 * @property integer $agent_id
 * @property integer $district_id
 * @property integer $apartments
 * @property integer $number_of_storeys
 * @property integer $number_of_entrances
 * @property string $apartments_pattern
 */
class Home extends \yii\db\ActiveRecord
{
    private static $_base;

        /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'home';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['street_id', 'number', 'agent_id', 'district_id', 'apartments'], 'required'],
            [['street_id', 'number', 'agent_id', 'district_id', 'apartments', 'number_of_storeys', 'number_of_entrances'], 'integer'],
            [['korpus'], 'string', 'max' => 5],
            [['apartments_pattern'], 'string', 'max' => 255],
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'number' => 'Номер дома:',
            'korpus' => 'Корпус:',
            'apartments' => 'Кол-во квартир:',
            'number_of_storeys' => 'Этажность:',
            'number_of_entrances' => 'Кол-во подъездов:',
            'apartments_pattern' => 'Шаблон распределения квартир по подъездам:',
            'fullname' => 'Наименование',
            'agent.name' => 'Агент',
            'district.name' => 'Район',
            'street.name' => 'Улица:',
            'countfloors' => 'Кол-во площадок',
        ];
    }
    
    /**
     * 
     * @return Связь с моделью Street
     */
    public function getStreet()
    {
        return $this->hasOne(Street::className(), ['id' => 'street_id']);
    }
    /**
     * 
     * @return Связь с моделью Agent
     */
    public function getAgent()
    {
        return $this->hasOne(Agent::className(), ['id' => 'agent_id']);
    }
    /**
     * 
     * @return Связь с моделью Районы
     */
    public function getDistrict()
    {
        return $this->hasOne(District::className(), ['id' => 'district_id']);
    }

    public function getFullName()
    {
        $fullname = $this->street->name." ".$this->number;
        if(!$this->korpus == NULL){
            $fullname = $fullname."/".$this->korpus;
        }
        return $fullname;
    }
    
//    public static function getIdByFullname($fullname)
//    {
//        $pattern = '/^(?<street>\D+\s?\D+)\s(?<home>\d*)[\/]?(?<korpus>\w?)/';
//        $home_id = NULL;
//        
//        if(preg_match($pattern, $fullname, $matches))
//        {
//            $street = $matches['street'];
//            $number = $matches['home'];
//            $korpus = $matches['korpus'];
//            
//            $street_id = Street::find()->where(['name' => $street])->one()->id;
//            $home = Home::find()->where(['street_id' => $street_id, 'number' => $number, 'korpus' => $korpus])->one();
//            if($home) {
//                $home_id=$home->id;
//            }
//        }
//        return $home_id;
//    }
    
    public static function getIdByFullname($fullname){
        
        if(is_null(self::$_base)){
            self::fillBase();
        }
        
        if(array_key_exists($fullname, self::$_base)){
            return self::$_base[$fullname];
        } else {
            return NULL;
        }
    }
    
    private static function fillBase(){
        
        $base = array();
        $tmp = Home::find()
                ->asArray()
                ->select('home.id, street.name, home.number, home.korpus')
                ->leftJoin('street', 'street.id=street_id')
                ->all();
        
        foreach ($tmp as $record){
            $id = $record['id'];
            $street = $record['name'];
            $num = $record['number'];
            $korp = $record['korpus'];
            
            $fullname = $street . " " . $num;
            if(!is_null($korp)){
                (!is_numeric($korp)) ?: $fullname .= "/";
                $fullname .= $korp;
            }    
            
            $base[$fullname] = $id;
        }
        
        self::$_base = $base;
    }

    public function getCountFloors()
    {
        if($this->number_of_storeys && $this->number_of_entrances) {
            return $this->number_of_storeys * $this->number_of_entrances;}
        else {
            return 'Н/Д';
        };
    }
    
    public function getStreets()
    {
        $streets = Street::find()->all();
        $result = helpers\ArrayHelper::map($streets, 'id', 'name');
        return $result;
    }
    
    public function getAgents()
    {
        $agents = Agent::find()->all();
        $result = helpers\ArrayHelper::map($agents, 'id', 'name');
        return $result;
    }
    
    public function getDistricts()
    {
        $districts = District::find()->all();
        $result = helpers\ArrayHelper::map($districts, 'id', 'name');
        return $result;
    }
}
