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
        $memory = $span->mem_end - $span->mem_start;
        $profiler->result[$span->name][] = ['time' => $time, 'memory' => $memory];
    }
    
    static public function getResult(){
        return self::getInstanse()->result;
    }
    
    static public function printResult(){
      
        $data = self::getResult();
        
        $res = "";
        
        $res .= "<button type='button' class='btn btn-info' data-toggle='collapse' data-target='#profiler'>Profiler Results</button>";
        $res .= "<div id='profiler' class='collapse'>";

        $res .= "<table class='table table-bordered'>";
        $res .= "<tr>";
        $res .= "<th>Name</th><th>Count</th><th>Time</th><th>Memory</th>";
        $res .= "</tr>";

        foreach ($data as $groupKey => $group){
            $res .= "<tr>";
            $res .= "<td>{$groupKey}</td>";
            
            $total_time = 0;
            $total_mem = 0;
            
            foreach ($group as $result){
                $res .= "<tr>";
                $res .= "<td></td><td></td>";
                    $res .= "<td>{$result['time']}</td>";
                    $total_time += $result['time'];
                    $res .= "<td>{$result['memory']}</td>";
                    $total_mem += $result['memory'];
                $res .= "</tr>";
            }
            
            $res .= "<tr><td>Total:</td><td>" . count($group) . "</td><td>{$total_time}</td><td>{$total_mem}</td></tr>";
            
            $res .= "</tr>";
        }
        
        $res .= "</table>";
        
        $res .= "</div>";
        
        return $res;
    }
            
}

class MyProfilerSpan {
    
    public $time_start;
    public $time_end;
    public $mem_start;
    public $mem_end;
    public $name;


    public function __construct() {
        $this->time_start = microtime(TRUE);
        $this->mem_start = memory_get_usage(TRUE);
    }
    
    public function Stop($name){
        
        $this->time_end = microtime(TRUE);
        $this->mem_end = memory_get_usage(TRUE);
        $this->name = $name;
        MyProfiler::Stop($this);
    }
    
}
