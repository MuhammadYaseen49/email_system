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

    // MY FILES
    require '../config/Database.php';
    require '../classes/mail.php';
    require '../middlewares/Auth.php';
    // PHP MAILER FILES
    require '../PHPMailer/vendor/phpmailer/phpmailer/src/Exception.php'; 
    require '../PHPMailer/vendor/phpmailer/phpmailer/src/PHPMailer.php'; 
    require '../PHPMailer/vendor/phpmailer/phpmailer/src/SMTP.php'; 

    // Import PHPMailer classes into the global namespace 
    use PHPMailer\PHPMailer\PHPMailer; 
    use PHPMailer\PHPMailer\Exception; 


    $db_connection = new Database();
    $db = $db_connection->dbConnection();

    $allHeaders = getallheaders();
    $auth = new Auth($db,$allHeaders);

    $mail = new PHPMailer;

    $data = json_decode(file_get_contents("php://input"));
    $returnData = [];

    $myMail = new myMail($db);

    if($_SERVER["REQUEST_METHOD"] == "POST"){

        $myMail->to = $data->to;
        $myMail->subject = $data->subject;
        $myMail->body = $data->body;
        $myMail->cc = $data->cc;
        $myMail->bcc = $data->bcc;

        // $from_username = $myMail->test_inputs($myMail->from_username);
        // $from = $myMail->test_email($myMail->from);
        $to = $myMail->test_email($myMail->to);
        $subject = $myMail->test_inputs($myMail->subject);
        $body = $myMail->test_inputs($myMail->body);
        $cc = $myMail->test_email($myMail->cc);
        $bcc = $myMail->test_email($myMail->bcc);

        if($to == null or $subject == null or $body == null){
            $fields = ['fields' => ['To','Subject','Body']];
            $returnData = msg(0,422,'Please Fill! All Required Fields!',$fields);
        }elseif($to==1){
            $returnData = msg(0,422,'There is an Invalid Email Address!');
        }elseif($data = $auth->isAuth()){
            $mailBy = $data['id'];
            $from_username = $data['name'];
            $from = $data['email'];
            $myMail->from = $from;
            $sender_password = $data['password'];
            
            $mail->isSMTP();                        // Set mailer to use SMTP 
            $mail->Host = 'smtp.gmail.com';         // Specify main and backup SMTP servers 
            $mail->SMTPAuth = true;                 // Enable SMTP authentication 
            $mail->Username = $from;      // SMTP username (sender email address)
            $mail->Password = $sender_password;          // SMTP password 
            $mail->SMTPSecure = 'tls';              // Enable TLS encryption, `ssl` also accepted 
            $mail->Port = 587;                      // TCP port to connect to 
            
            // Sender info 
            $mail->setFrom($from, $from_username); 
            $mail->addReplyTo($from, $from_username); 
            
            // Add a recipient 
            $mail->addAddress($to); 
            
            $mail->addCC($cc); 
            $mail->addBCC($bcc); 
            
            // Set email format to HTML 
            $mail->isHTML(true); 
            
            // Mail subject 
            $mail->Subject = $subject; 
            // $mail->addAttachment('download.png','Programmers Force');
            
            // Mail body content 
            $bodyContent = '<p>' . $body . '</p>';
            // $bodyContent .= '<p>Programmers Force</p>'; 
            $mail->Body    = $bodyContent; 
            
            // Send email 
            if($mail->send()){
                if($myMail->insert($mailBy)){
                    $returnData = [
                        'success' => 1,
                        'status' => 201,
                        'message' => 'Email has been sent.'
                    ];
                }else{
                    $returnData = [
                        'success' => 0,
                        'status' => 422,
                        'message' => 'Email Cannot Insert in Database.'
                    ];
                }
            }else{ 
                $returnData = [
                    'success' => 0,
                    'status' => 422,
                    'message' => 'Email could not be sent. Mailer Error: '.$mail->ErrorInfo
                ];
            }
        }else{
            $returnData = [
                "success" => 0,
                "status" => 401,
                "message" => "Unauthorized"
            ];
        }
    }else{
        $returnData = msg(0,404,'Page Not Found!');
    }  

    echo json_encode($returnData);

?>