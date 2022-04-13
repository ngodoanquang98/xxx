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
    try {
        initialize();
        initEvents();
        $('#out').datepicker({
            dateFormat: "yy/mm/dd",
            changeYear: true,
            changeMonth: true,
        });
    } catch (e) {
        alert('ready' + e.message);
    }
});

function initialize() {
    try {
        getData();
        dateTime();
    } catch (e) {
        alert('initialize ' + e.message);
    }
}
function initEvents() {
    //post
    $(document).on('click', '#save', function () {
        var no = $('#no').val()
        var name = $('#name').val()
        var age = $('#age').val()
        var sex = $("input[name='flexRadioDefault']:checked").val()
        var address = $('#add').val()
        var company_in = $('#in').val()
        var company_out = $('#out').val()
        try {
            $.ajax({
                type: 'POST',
                url: 'https://622885819fd6174ca8269cdb.mockapi.io/call_api',
                dataType: 'json',
                loading: true,
                data: {
                    No: no,
                    name: name,
                    age: age,
                    sex: sex,
                    address: address,
                    company_in: company_in,
                    company_out: company_out
                },
                success: function (res) {
                    location.reload()
                }
            });
        } catch (e) {
            alert('#save' + e.message);
        }
    })
}
//get
function getData() {
    try {
        $.ajax({
            type: 'GET',
            url: 'https://622885819fd6174ca8269cdb.mockapi.io/call_api',
            dataType: 'json',
            loading: true,
            success: function (data) {
                $.each(data, function (key, value) {
                    $('#show').append(`
                <tr>
                  <td class="ri" scope="row">${key + 1}</td>
                  <td class="ri">${value.No}</td>
                  <td>${value.name}</td>
                  <td class="ri">${value.age}</td>
                  <td class="ri">${value.sex}</td>
                  <td>${value.address}</td>
                  <td id="inout">${value.company_in}</td>
                  <td id="inout">${value.company_out}</td>
                  <td style="background-color:red; text-align:center" onclick ="delEmp(${value.id})">x</td>
                </tr>
            `)
                })
            }
        });
    } catch (e) {
        alert('get data' + e.message);
    }
}
//delete
function delEmp($id) {
    try {
        $.ajax({
            type: 'DELETE',
            url: 'https://622885819fd6174ca8269cdb.mockapi.io/call_api/' + $id,
            dataType: 'json',
            loading: true,
            success: function (data) {
                alert('xoa thanh cong')
                location.reload()
            },
            error: function (error) {
                alert(error)
            }
        });
    } catch (e) {
        alert('delete' + e.message);
    };
};
//yyyy/mm/dd
function dateTime() {
    try {
        $('#in').datepicker({
            dateFormat: "yy/mm/dd",
            changeYear: true,
            changeMonth: true,
        });
        $('#out').datepicker({
            dateFormat: "yy/mm/dd",
            changeYear: true,
            changeMonth: true,
        });
    }catch (e) {
        alert('time yy/mm/dd' + e.message);
    };
}