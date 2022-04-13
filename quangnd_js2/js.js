/**
****************************************************************************
* Call-api
* SCREEN ID Controller
* 
* 処理概要/process overview : search all employees in company
* 作成日/create date : 2022/03/11
* 作成者/creater : quangnd-quangnd@ans-asia.com
*
Tài liệu nội bộ
Copyright ©ANS-AISA. All rights reserved. 
* @package : MODULE NAME
* @copyright : Copyright (c) ANS-ASIA
* @version : 1.0.0
* **************************************************************************
*/
$(document).ready(function () {
    $("#ip").keyup(function () {
        try {
            //var id = $(this).val()
            $("p").text($(this).val())
        } catch (e) {
            console.log("#ip " + e.message)
        }
    })
    $("#ip").click(function () {
        try {
            alert("Welcome Ans-asia")
        } catch (e) {
            console.log("#ip " + e.message)
        }
    })
});
