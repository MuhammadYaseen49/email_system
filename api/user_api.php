<?php
    header("Access-Control-Allow-Origin: *");
    header("Access-Control-Allow-Methods: POST");
    header("Content-Type: application/json; charset=UTF-8");
    header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

    function msg($success,$status,$message,$extra = []){
        return array_merge([
            'success' => $success,
            'status' => $status,
            'message' => $message
        ],$extra);
    }

    require '../config/Database.php';
    require '../classes/user.php';
    require '../middlewares/Auth.php';

    $db_connection = new Database();
    $db = $db_connection->dbConnection();

    $allHeaders = getallheaders();
    $auth = new Auth($db,$allHeaders);

    $data = json_decode(file_get_contents("php://input"));
    $returnData = [];

    // IF REQUEST METHOD IS NOT EQUAL TO POST

        $user = new addUser($db);

        if($_SERVER["REQUEST_METHOD"] == "POST"){
            $user->name = $data->name;
            $user->email = $data->email;
            $user->password = $data->password;

            $name = $user->test_inputs($user->name);
            $email = $user->test_email($user->email);
            $password = $user->test_password($user->password);

            if($name == null or $password == null or $email == null){
                $fields = ['fields' => ['name','email','password']];
                $returnData = msg(0,422,'Please Fill! All Required Fields!',$fields);
            }elseif($email==1){
                $returnData = msg(0,422,'Invalid Email Address!');
            }else{
                if($data = $auth->isAuth()){
                $merchant_id = $data['id'];
                $user->addUser($merchant_id);
                $returnData = [
                            'success' => 1,
                            'status' => 201,
                            'message' => 'Your Secondary User Successfully Created.',
                            ];
                }else{
                        $returnData = [
                            "success" => 0,
                            "status" => 401,
                            "message" => "Unauthorized"
                        ];
                }
            }
        }else{
            $returnData = msg(0,404,'Page Not Found!');
        }


    echo json_encode($returnData);