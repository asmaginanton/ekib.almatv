<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "comment".
 *
 * @property integer $id
 * @property string $ref_type
 * @property integer $ref_id
 * @property string $date
 * @property string $author
 * @property string $comment
 */
class Comment extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'comment';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['ref_type', 'ref_id', 'author', 'comment'], 'required'],
            [['ref_id'], 'integer'],
            [['date'], 'safe'],
            [['ref_type'], 'string', 'max' => 10],
            [['author'], 'string', 'max' => 100],
            [['comment'], 'string', 'max' => 255],
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'ref_type' => 'Ref Type',
            'ref_id' => 'Ref ID',
            'date' => 'Date',
            'author' => 'Author',
            'comment' => 'Comment',
        ];
    }
    
    public static function WriteComment($ref_type, $ref_id, $message, $author = 'system'){
        $comment = new Comment();
        $comment->ref_type = $ref_type;
        $comment->ref_id = $ref_id;
        $comment->comment = $message;
        $comment->author = Yii::$app->user->identity->username;
        $comment->date = date('Y-m-d H:i');
        $comment->save();
    }
}
