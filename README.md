# robot-framewrok-20201209
1. Create the virtual environment
virtualenv venv 
2. Gán quyền thực thi cho các scripts
chmod +rx scripts/setup.sh
3. Robot framework
    Thành phần cơ bản của một file kịch bản của Robot Framework gồm 3 phần chính: Settings, Test Cases và Keywords.
    
    Phần Settings sẽ định nghĩa các thành thiết lập khởi đầu cho kịch bản, như là mô tả xem nó sẽ làm gì, dùng thư viện nào.
    *** Settings ***
    Documentation     A test suite containing tests related to invalid login.
    ...
    ...               These tests are data-driven by their nature. They use a single
    ...               keyword, specified with Test Template setting, that is called
    ...               with different arguments to cover different scenarios.
    ...
    ...               This suite also demonstrates using setups and teardowns in
    ...               different levels.
    
    Suite Setup       Open Browser To Login Page
    Suite Teardown    Close Browser
    
    Test Setup        Go To Login Page
    Test Template     Login With Invalid Credentials Should Fail
    
    Library           Selenium2Library
    Resource          resource.robot
    
    Như VD ở trên ta có thể thấy gồm các thành phần:
    
    Documentation: Mô tả khái quát về nội dung test.
    Suite Setup/Teardown: Gọi đến các Keywords để khi bắt đầu/kết thúc chạy test.
    Resource: Import các file khác để tái sử dụng lại các Keywords.
    Library: Import các thư viện hỗ trợ test.
    Phần Test Cases là phần chính bao gồm các trường hợp cần test, trong phần này ta chỉ cần gọi các Keywords để chúng chạy và kiểm tra xem Output có đúng với Expected không.
    Normal Syntax:

    *** Test Cases ***
    Valid Login
        Open Browser To Login Page
        Input Username    demo
        Input Password    mode
        Submit Credentials
        Welcome Page Should Be Open
        [Teardown]    Close Browser
     
    Đặc biệt với phần Gherkin bên dưới, cách viết rất gần với ngôn ngữ tự nhiên nên hoàn toàn có thể để Khách Hàng viết Test Case trước, sau đó chúng ta sẽ implement sau đó, rất dễ dàng và hiệu quả.

    Gherkin Syntax:    
    *** Test Cases ***
    Valid Login
        Given browser is opened to login page
        When user "demo" logs in with password "mode"
        Then welcome page should be open
    
    Data-driven Syntax:
    *** Test Cases ***               USER NAME        PASSWORD
    Invalid Username                 invalid          ${VALID PASSWORD}
    Invalid Password                 ${VALID USER}    invalid
    Invalid Username And Password    invalid          whatever
    Empty Username                   ${EMPTY}         ${VALID PASSWORD}
    Empty Password                   ${VALID USER}    ${EMPTY}
    Empty Username And Password      ${EMPTY}         ${EMPTY}
    
    Keywords là các step từ chuẩn bị cho đến việc kiểm tra kết quả, Robot là thế giới của các keywords. Trong keywords chúng ta cũng gọi đến những keywords khác để thực hiện các xử lý.
    *** Keywords ***
    Login With Invalid Credentials Should Fail
        [Arguments]    ${username}    ${password}
        Input Username    ${username}
        Input Password    ${password}
        Submit Credentials
        Login Should Have Failed
    
    Login Should Have Failed
        Location Should Be    ${ERROR URL}
        Title Should Be    Error Page    
    
    Bản thân các Keywords có thể nhận các đối số để sử dụng trong các trường hợp tương tự nhau, ví dụ như nhập Input Text, Submit Form,... Ngoài ra các keywords hoàn toàn có thể định nghĩa tự do bằng bất cứ ngôn ngữ nào, chỉ cần phần Test Cases gọi đúng như vậy là được.
    
    Tham khảo thêm tại link
    https://blog.vietnamlab.vn/automation-test-voi-robot-framework/
    http://qr-solutions.com.vn/2019/03/28/robot-framework-cong-cu-opensource-cho-automation-test-de-dang-hon-cho-cac-ban-tester-mong-muon-hoc-1-tool-test-nao/
    