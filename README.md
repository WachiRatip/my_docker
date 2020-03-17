# my docker example
## วิธีใช้งานแบบ step by step
#### สำหรับผู้ใช้ windows/macOS
    1. เข้าเว็บ https://www.docker.com/products/docker-desktop เพื่อดาวน์โหลด docker desktop ตาม OS
    2. ติดตั้ง docker desktop พร้อมเปิดใช้งาน(ถ้าโปรแกรมไม่ได้เปิดอัตโนมัติหลังติดตั้งเสร็จ)
    3. ตั้งค่าการใช้ทรัพยากรในหน้า setting ของ docker desktop 
        -cpu ควรเปิดให้ครึ่งหนึ่งของที่มีเช่นมี 8 threads ควรเปิดให้ 4 threads
        -ram ในทำนองเดียวกันกับ cpu เช่น มี 8GB ควรเปิดให้ 4GB
        -swap ตั้งให้น้อยที่สุดเท่าที่เป็นไปได้ 
        -เปิด fileshare ด้วย
    4. เปิด PowerShell(สำหรับ Windows) หรือ Terminal(สำหรับ macOS)
    5. พิมพ์ docker image ls ถ้าไม่มี error ขึ้นแปลว่าใช้ได้แล้ว
    6. ย้าน directory ด้วยคำสั่ง cd มาที่ directory ที่ dockerfile อยู่ เช่น    
        cd .\Desktop\my_docker\ (สำหรับ windows) หรือ   
        cd ./Desktop/my_docker/ (สำหรับ macOS)
    7. พิมพ์คำสั่งต่อไปนี้เพื่อสร้าง container 
        .\build.ps1 start (สำหรับ windows) หรือ   
        source build.sh start (สำหรับ macOS)
    8. พิมพ์คำสั่งต่อไปนี้เพื่อหยุดและลบ container
        .\build.ps1 stop (สำหรับ windows) หรือ   
        source build.sh stop (สำหรับ macOS)
#### สำหรับผู้ใช้ linux
    1. ให้ติดตั้ง docker ce ตามคำแนะนำตาม distro ทีใช้งาน
    2. ข้ามขั้นตอน 1., 2., 3. แล้วใช้แนวทางเดียวกับ macOS (ขึ้นอยู่กับ distro)

### อธิบาย dockerfile
    FROM <image>:<tag>
    หมายถึงให้สร้าง docker image ขึ้นมาใหม่โดยใช้ <image>:<tag> ที่กำหนดเป็นฐาน

    WORKDIR <path>
    หมายถึงกำหนด path การทำงานเริ่มต้นของ container โดยทั่วไปแนะนำ /home หรือ /app หรือ /usr/src/workdir หรือ /usr/src/app

    EXPOSE <port>
    หมายถึงกำหนด port หมายเลข <port> เป็น port ในการสื่อสาร

    VOLUME <path>
    หมายถึงกำหนด directory ตาม <path> ให้เป็น VOLUME จะเชื่อมกับตัว OS หลัก

    COPY <host_path/file> <container_path>
    หมายถึงให้ copy derectory หรือ file ตาม <host_path/file> ไปยัง Path <container_path> ของ container

    RUN <command>
    หมายถึงให้รันคำสั่ง <command> ใน container เช่น
    RUN pip install -U pip จะทำการรันคำสั่ง pip install -U pip

    CMD ["<command_1>", "<command_2>", "<command_3>", ...]
    เมื่อ container ถูกรันให้รันคำสั่ง <command_1> <command_2> <command_3> ... เช่น CMD ["jupyter", "notebook"]
    จะทำการรันคำสั่ง jupyter notebook เมื่อมีการรัน container

### command สำหรับ docker
    สำหรับสร้าง (build) docker image ให้พิมพ์
        docker build -t <ชื่อ image>:<tag image> . เช่น
        docker build -t python377:1.0.0 .

    สำหรับสร้างและรัน (build&run) docker container ให้พิมพ์
        docker run -p <host_port>:<container_port> --name <ชื่อ container> -v <host_volume>:<container_volume> <ชื่อ image>:<tag image> เช่น
        docker run -p 8888:8888 --name container_python377 -v ${pwd}\source:/home  python377:1.0.0 (สำหรับ windows) หรือ  
        docker run -p 8888:8888 --name container_python377 -v $(pwd)/source:/home  python377:1.0.0 (สำหรับ macOS)/Linux

    สำหรับตรวจสอบ image ที่มีให้พิมพ์
        docker image ls

    สำหรับตรวจสอบ docker container ที่รันอยู่ ให้พิมพ์
        docker ps

    สำหรับตรวจสอบ docker container ที่มีทั้งหมด ให้พิมพ์
        docker ps -a

    สำหรับหยุด container 1 ตัวให้พิมพ์ (ใช้ docker ps เพื่อดูเลขในคอลัมน์แรก)
        docker stop <เลข container>

    สำหรับหยุด container ทั้งหมดให้พิมพ์
        docker stop $(docker ps -aq) 

    สำหรับลบ container 1 ตัวให้พิมพ์ (ใช้ docker ps -a เพื่อดูเลขในคอลัมน์แรก)
        docker rm <เลข container>

    สำหรับลบ container ทั้งหมดให้พิมพ์
        docker rm -f $(docker ps -aq)

    สำหรับลบ image ทั้งหมด(ที่ไม่ได้ใช้งานอยู่)ให้พิมพ์
        docker image prune -a -f

    สำหรับลบ volume ทั้งหมด(ที่ไม่ได้ใช้งานอยู่)ให้พิมพ์  
        docker volume prune -f