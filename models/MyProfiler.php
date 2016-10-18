<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace app\models;

/**
 * Description of MyProfiler
 *
 * @author anton.smagin
 */
class MyProfiler {
    
    static private $_instance = null;
    
    private $result = array();
    
    private function __construct() {
        
    }
    
    static private function getInstanse(){
        if(is_null(self::$_instance)){
            self::$_instance = new self();
        }
        return self::$_instance;
    }
    
    static public function Start(){
        
        return new MyProfilerSpan();
        
    }
    
    static public function Stop(MyProfilerSpan $span){
        $profiler = self::getInstanse();
        $time = round($span->time_end - $span->time_start, 4);
        $profiler->result[$span->name][] = ['time' => $time];
    }
    
    static public function getResult(){
        return self::getInstanse()->result;
    }
            
}

class MyProfilerSpan {
    
    public $time_start;
    public $time_end;
    public $name;


    public function __construct() {
        $this->time_start = microtime(TRUE);
    }
    
    public function Stop($name){
        
        $this->time_end = microtime(TRUE);
        $this->name = $name;
        MyProfiler::Stop($this);
    }
    
}
