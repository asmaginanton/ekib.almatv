<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace app\models;

/**
 * Description of Utilites
 *
 * @author Администратор
 */
class Utilites {
    
    static function csv_to_array($filename='', $encoding = true, $delimiter=';')
    {
        if(!file_exists($filename) || !is_readable($filename))
            return FALSE;

        $header = NULL;
        $data = array();
        if (($handle = fopen($filename, 'r')) !== FALSE)
        {
            while (($row = fgets($handle)) !== FALSE)
            {
                !$encoding ?: $row = iconv('windows-1251', 'utf-8', $row); // Если необходимо изменить кодировку файла
                if(!$header)
                    $header = explode(';', $row);
                else
                    $data[] = array_combine($header, explode(';', $row));
            }
            fclose($handle);
        }
        return $data;
    }
    
    
}
