<?php

namespace app\models;

use yii\base\NotSupportedException;
use Yii;
use developeruz\db_rbac\interfaces\UserRbacInterface;

class User extends \yii\db\ActiveRecord implements \yii\web\IdentityInterface, UserRbacInterface
{
    public static function tableName() {
        
        return 'auth_users';
    }
    
    public function attributeLabels() {
        parent::attributeLabels();
        
        return [
            'login' => 'Логин',
            'username' => 'Имя пользователя',
            'password' => 'Пароль',
        ];
    }
    
    public function rules() {
        
        return [
            [['login','username','password'],'required'],
        ];
        
    }
    
   
    /**
     * @inheritdoc
     */
    public static function findIdentity($id)
    {
        return static::findOne(['id' => $id]);
    }

    /**
     * @inheritdoc
     */
    public static function findIdentityByAccessToken($token, $type = null)
    {
        throw new NotSupportedException('"findIdentityByAccessToken" is not implemented.');
    }
    /**
     * Finds user by username
     *
     * @param string $username
     * @return static|null
     */
    public static function findByUsername($username)
    {
        return static::findOne(['login' => $username]);
    }

    /**
     * @inheritdoc
     */
    public function getId()
    {
        return $this->getPrimaryKey();
    }
    
    public function getUserName() {
        
        return $this->username;;
    }

    /**
     * @inheritdoc
     */
    public function getAuthKey()
    {
        return $this->auth_key;
    }

    /**
     * @inheritdoc
     */
    public function validateAuthKey($authKey)
    {
        return $this->getAuthKey() === $authKey;
    }

    /**
     * Validates password
     *
     * @param string $password password to validate
     * @return boolean if password provided is valid for current user
     */
    public function validatePassword($password)
    {
        try{
            
            return Yii::$app->security->validatePassword($password, $this->password);
            
        } catch (\yii\base\InvalidParamException $ex) {
            return FALSE;
        }
        
    }
  
}
