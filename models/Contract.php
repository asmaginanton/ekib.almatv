<?php

namespace app\models;

use Yii;
use \yii\helpers;

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
    private static $_casheInsert;

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
    
    public static function getAll(){
        
        $span_getAllContracts = MyProfiler::Start();
        
        $contracts = Contract::find()
                ->asArray()
                ->select(['contract.*','abonent.fullname','street.name','home.number as num','home.korpus','address.apartment']) 
                ->leftJoin('address', 'address.id = contract.address_id')
                ->leftJoin('home', 'address.home_id = home.id')
                ->leftJoin('street', 'home.street_id = street.id')
                ->leftJoin('abonent', 'abonent.id = contract.abonent_id')
                ->all();
        
        $result = helpers\ArrayHelper::index($contracts, 'number');
        
        $span_getAllContracts->Stop('get all contracts');
        
        return $result;
    }
    
    public static function fetchInsertCashe()
    {
        \Yii::$app->db->createCommand()
                ->batchInsert('abonent', ['id', 'fullname', 'mobile', 'phone'], self::$_data)
                ->execute();
    }
}
