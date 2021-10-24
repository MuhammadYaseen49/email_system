<?php
    class read{
        public function __construct($db){
            $this->conn = $db;
        }

        public function fetch_email(){
            $select = "SELECT e.id,e.fromUser,e.toUser,e.cc,e.bcc,e.subject,e.body,u.name FROM emails as e LEFT JOIN users as u ON u.id = e.mailBy";
            $run_select = $this->conn->prepare($select);
            $run_select->execute();
            $fetch_data = $run_select->fetchAll(PDO::FETCH_ASSOC);
            //   $fetch_data += array("Status Code"=>"200");
            return $fetch_data;
        }
    }
?>