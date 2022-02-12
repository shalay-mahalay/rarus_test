<?php

    use PHPMailer\PHPMailer\PHPMailer;
    use PHPMailer\PHPMailer\Exception;

    require "PHPMailer/src/Exception.php";
    require "PHPMailer/src/PHPMailer.php";

    $mail = new PHPMailer(true);
	
    $mail->CharSet = "UTF-8";
    $mail->IsHTML(true);

    $name = $_POST["fio"];
    $email = $_POST["email"];
	$phone = $_POST["phone"];
    $message = $_POST["message"];
    $adress = $_POST["adress"];
	$email_template = "template_mail.html";

    $body = file_get_contents($email_template);
	$body = str_replace('%name%', $name, $body);
	$body = str_replace('%email%', $email, $body);
	$body = str_replace('%phone%', $phone, $body);
    $body = str_replace('%adress%', $adress, $body);
	$body = str_replace('%message%', $message, $body);

    $mail->addAddress("your_mail@email.com");   // Здесь введите Email, куда отправлять
	$mail->setFrom($email);
    $mail->Subject = "[Заявка с формы]";
    $mail->MsgHTML($body);

    if(preg_match("/@gmail.com$/", $email) {
        $message = "Недопустимый адрес почты"
    } esle if(
        preg_match("/^[а-яА-ЯёЁa-zA-Z]+ [а-яА-ЯёЁa-zA-Z]+ ?[а-яА-ЯёЁa-zA-Z]+$/", $name) 
        && preg_match("/^[а-яА-ЯёЁa-zA-Z]+ [а-яА-ЯёЁa-zA-Z]+ ?[а-яА-ЯёЁa-zA-Z]+$/", $phone)) {
            if (!$mail->send()) {
                $message = "Ошибка отправки";
            } else {
                $message = "Данные отправлены!";
            }
        } else $message = "Некорректные данные";


	$response = ["message" => $message];

    header('Content-type: application/json');
    echo json_encode($response);


?>