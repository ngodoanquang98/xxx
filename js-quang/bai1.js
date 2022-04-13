/**
****************************************************************************
* BAI JAVASCRIP
* SCREEN ID Controller
* 
* 処理概要/process overview :bai tap
* 作成日/create date : 2022/03/10
* 作成者/creater : quangnd-quangndd@ans-asia.com
* **************************************************************************
*/

const ipnElement = document.querySelector('input')

$("#btn1").click(function () {
    const yearOfBirth = parseInt(ipnElement.value)
    const date = new Date()
    const currentYear = date.getFullYear()
    const age = currentYear - yearOfBirth
    if (age > 0) {
        alert(`bạn: ${age} tuổi`)
    } else {
        alert("ban nhập sai thông tin")
    }
})
function kiemTraSnt(n) {
    // Biến cờ hiệu
    var is_prime = true;

    // Nếu n bé hơn 2 tức là không phải số nguyên tố
    if (n < 2) {
        is_prime = false;
    }
    else if (n == 2) {
        is_prime = true;
    }
    else if (n % 2 == 0) {
        is_prime = false;
    }
    else {
        // lặp từ 3 tới n-1 với bước nhảy là 2 (i+=2)
        for (var i = 3; i < Math.sqrt(n); i += 2) {
            if (n % i == 0) {
                is_prime = false;
                break;
            }
        }
    }
    // Kiểm tra biến is_prime
    if (is_prime == true) {
        alert(n + " số nhập vào là số nguyên tố");
    }
    else {
        alert(n + " số nhập vào không phải là số nguyên tố ");
    }
}


$("#btn2").click(function () {
    const snt = parseInt(ipnElement.value)
    kiemTraSnt(snt)
})


$("#btn3").click(function () {
    var a = parseInt($("input[name='a']").val())
    var c = ($("input[name='b']").val()).toString()
    var b = parseInt($("input[name='c']").val())
    switch (c) {
        case "+":
            alert(a + b)
            break;
        case "-":
            alert(a - b)
            break;
        case "*":
            alert(a * b)
            break;
        case "/":
            (b != 0)?alert(a / b):alert("b phải khác 0")
            break;
        default:
            alert("vui lòng nhập lại")
    }

});

let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 23, 56];
$(document).ready(function () {
    document.getElementById("demo").innerHTML = numbers.reduce(getSum, 0);
});

function getSum(total, num) {
    return total + Math.round(num);
}
$("#btn").click(function () {

    var a = parseInt($("input[name='s']").val())
    document.getElementById("search").innerHTML = numbers[a]
});
$("#bt").click(function () {
    var a = parseInt($("input[name='s']").val())
    numbers.splice(a, 0, 888);
    console.log(numbers)
});
