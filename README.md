# Cửa Hàng Sách Trực Tuyến

Dự án này là một ứng dụng web cửa hàng sách trực tuyến được xây dựng bằng Django. Thực hiện theo các hướng dẫn dưới đây để thiết lập và triển khai ứng dụng trên máy chủ Ubuntu.

## Yêu Cầu

- **Ubuntu 20.04** hoặc phiên bản mới hơn (hoặc một phiên bản Linux tương thích khác)
- **Python 3.12** (hoặc phiên bản tương thích khác)
- **Nginx** (cho triển khai sản xuất)

## Cài Đặt và Thiết Lập

1. **Nhân Bản Kho Lưu Trữ**:

   - Nhân bản kho lưu trữ dự án về máy tính của bạn và di chuyển vào thư mục dự án:
     ```bash
     git clone https://github.com/best-ff/bookstore-web.git
     cd bookstore-web
     ```

2. **Thiết Lập Môi Trường Python**:

   - Cập nhật danh sách gói và cài đặt gói môi trường ảo Python 3.12:
     ```bash
     sudo apt-get update
     sudo apt-get install python3.12-venv -y
     ```
   - Tạo môi trường ảo và kích hoạt nó:
     ```bash
     python3.12 -m venv myenv
     source myenv/bin/activate
     ```
   - Cài đặt các gói phát triển bổ sung và các phụ thuộc Python cần thiết cho dự án:
     ```bash
     sudo apt-get install python3.12-dev build-essential libmysqlclient-dev pkg-config -y
     pip install mysqlclient django
     ```

3. **Áp Dụng Di Chuyển Cơ Sở Dữ Liệu**:

   - Chạy các di chuyển cơ sở dữ liệu của Django để tạo các bảng cần thiết trong cơ sở dữ liệu của bạn:
     ```bash
     python manage.py migrate
     ```

4. **Thiết Lập Nginx Cho Sản Xuất**:

   - Cập nhật danh sách gói và cài đặt Nginx:
     ```bash
     sudo apt-get update
     sudo apt install nginx -y
     ```
   - Tạo chứng chỉ SSL tự ký (có thể sử dụng Let's Encrypt để cấp chứng chỉ miễn phí):
     ```bash
     sudo mkdir -p /etc/nginx/ssl
     sudo openssl req -x509 -newkey rsa:4096 -keyout /etc/nginx/ssl/nginx.key -out /etc/nginx/ssl/nginx.crt -days 365 -nodes
     ```
   - Tạo một tệp cấu hình Nginx mới:

     ```bash
     sudo nano /etc/nginx/sites-available/domain
     ```

     Thêm cấu hình sau vào tệp cấu hình Nginx:

     ```nginx
     server {
         listen 80;
         server_name 9.9.9.9;
     
         location / {
             proxy_pass http://localhost:8000;
             proxy_set_header Host $host;
             proxy_set_header X-Real-IP $remote_addr;
             proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
             proxy_set_header X-Forwarded-Proto $scheme;
         }
     }

     server {
         listen 443 ssl;
         server_name 9.9.9.9;

         ssl_certificate /etc/nginx/ssl/nginx.crt;
         ssl_certificate_key /etc/nginx/ssl/nginx.key;
         ssl_protocols TLSv1.2 TLSv1.3;
         ssl_ciphers 'ECDHE-RSA-AES256-GCM-SHA384:ECDHE-RSA-AES128-GCM-SHA256';
         ssl_prefer_server_ciphers on;

         location / {
             proxy_pass http://localhost:8000;
             proxy_set_header Host $host;
             proxy_set_header X-Real-IP $remote_addr;
             proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
             proxy_set_header X-Forwarded-Proto $scheme;
         }
     }
     ```

   - Kích hoạt cấu hình Nginx mới và khởi động lại dịch vụ Nginx:
     ```bash
     sudo ln -s /etc/nginx/sites-available/domain /etc/nginx/sites-enabled/
     sudo systemctl restart nginx
     ```

5. **Chạy Máy Chủ Phát Triển**:

   - Khởi động máy chủ phát triển Django để xem trước ứng dụng tại địa phương:
     ```bash
     python manage.py runserver 0.0.0.0:8000
     ```

6. **Cập Nhật Cài Đặt Của Ứng Dụng**:

   - Mở tệp `settings.py`:
     ```bash
     sudo nano core/settings.py
     ```

   - Cập nhật `ALLOWED_HOSTS`:
     ```bash
     ALLOWED_HOSTS = ['9.9.9.9']
     ```
     
   - Cập nhật `DATABASES`:
     ```bash
     sudo nano core/settings.py
     ```
     
Ứng dụng của bạn hiện đã có thể truy cập qua `https://9.9.9.9`.
