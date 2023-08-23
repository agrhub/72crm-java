### Wukong CRM9.0 (JAVA version)
Wukong Software has long provided enterprises with information services integrating R&D, implementation, marketing, consulting, training and service of enterprise management software (CRM/HRM/OA/ERP, etc.). Wukong Software takes high technology as the starting point, technology as the core, and perfect after-sales service as the backing, adhering to the spirit of stability and development, truth-seeking and innovation, and has provided services to thousands of enterprises at home and abroad.

Wukong's development has benefited from open source and will also contribute to open source. In 2019, Wukong CRM will continue to uphold the concept of "embrace openness, win-win cooperation, and create value", continue to forge ahead on the road of open source, and make positive contributions to open source at home and abroad with more community developers.

Official website: [http://www.5kcrm.com](http://www.5kcrm.com/)

Official website: [http://www.72crm.com](http://www.72crm.com/)

Forum: [http://bbs.72crm.net](http://bbs.72crm.net/)

Demo address: [demo9java.5kcrm.net](http://demo9java.5kcrm.net/) (account: 18888888888 password: 123456)

 :tw-1f495: **JAVA version of QQ group exchange group①group**: [1026560336](https://shang.qq.com/wpa/qunwpa?idkey=13d5e5809eb9feb350336e55c8b7a00b9cb472078b09b4441222a52dd76b278e)


Scan the QR code to add Xiaowu's official customer service WeChat, and invite you to join the WeChat exchange group:

<img src="https://images.gitee.com/uploads/images/2019/1231/115927_f9c580c8_345098.png" width="200">


Follow Wukong CRM official account to learn more about Wukong

<img src="https://images.gitee.com/uploads/images/2019/1202/140117_0217f5aa_345098.jpeg" width="200">






Wukong CRM adopts a new front-end and back-end separation mode. This warehouse code has integrated the front-end vue packaged files, which can eliminate the packaging operation

If you need to adjust the front-end code, please download the front-end code separately, the front-end code is in the ux folder of the root directory


## Main technology stack

Core framework: jfinal3.8

Cache: redis caffeine

Database connection pool: Druid

Tools: hutool, fastjson, poi-ooxml

Timing task: jfinal-cron

Project build tool: maven

Web container: tomcat, undertow (default)

Front-end MVVM framework: Vue.JS 2.5.x

Routing: Vue-Router 3.x

Data interaction: Axios

UI framework: Element-UI 2.6.3



## Installation Notes

1. Configure java operating environment, redis environment and mysql environment.
2. Import crm9.sql under the directory doc into the database (`Initial installation only needs to import crm9.sql, update the code and import the sql file of the corresponding date`).
3. Modify the database configuration file under `resources/config/crm9-config.txt`.
4. Modify the redis connection file under `resources/config/redis.json`
5. Undertow start port number is modified under `resources/config/undertow.txt`.
Default account admin Default password 123456



## Deployment instructions

The JDK of this project requires JDK8 and above


### One, Undertow (default)


```
<dependency>
    <groupId>com.jfinal</groupId>
    <artifactId>jfinal-undertow</artifactId>
    <version>1.9</version>
</dependency>
```

Uncomment the above code, comment out the tomcat pom dependency javax.servlet.javax.servlet-api, change the packaging method to jar and run maven package, after the packaging is complete
Upload the crm9-release.zip file generated by the above packaging command to the server and decompress it, and run the corresponding 72crm.sh/72crm.bat.

### Two, Tomcat deployment


```
<dependency>
    <groupId>javax.servlet</groupId>
    <artifactId>javax.servlet-api</artifactId>
    <version>4.0.1</version>
    <scope>provided</scope>
</dependency>
```

Uncomment the above code, comment out the undertow pom dependency com.jfinal.jfinal-undertow, comment out the main method of com.kakarote.crm9.Application, and change the packaging method to war.
Run the maven package command and place the war package in the `tomcat/webapps` directory

The default project is ROOT.war. If you need to carry the project name, you need to modify the BASE_API of ux/config/prod.env.js to'"/project name/"'. After the modification is completed, you need to repackage and replace it under webapp


The project webapp comes with the packaged front-end code, if you don’t need to change the front-end code, just visit it directly
If you change the front-end code, you need to replace the static folder and index.html under the packaged dist under webapp
ps: You can use `nginx` to proxy static files. The background only responds to the interface. The design of the project itself is completely separated from the front and back ends.



### Front-end deployment

Installing node.js The front-end part is based on node.js running, so you must first install `node.js`, the version requirement is 6.0 or more

Use npm to install dependencies Download the Wukong CRM9.0 front-end code; you can place the code in the back-end directory ux at the same level, and execute the command to install the dependencies:

    npm install

Modify internal configuration Modify request address or domain name: Modify BASE_API (development environment server address, default localhost) in config/dev.env.js Modify custom port: port parameter of dev object in config/index.js (default 8090, It is not recommended to modify)

### Run the front end

     npm run dev

Note: When the front-end service is started, port 8090 is occupied by default, so before starting the front-end service, please make sure that port 8090 is not occupied.
The server must be built before the program runs



## system introduction

The following is a screenshot of some functional systems of Wukong CRM9.0 JAVA version

![Enter picture description](https://images.gitee.com/uploads/images/2019/0523/093932_dacf59fe_345098.png "g4.png")
![Enter picture description](https://images.gitee.com/uploads/images/2019/0523/093941_44519a69_345098.png "g1.png")
![Enter picture description](https://images.gitee.com/uploads/images/2019/0523/093950_3dfe6ad0_345098.png "g3.png")
![Enter picture description](https://images.gitee.com/uploads/images/2019/0523/093957_e39d2e09_345098.png "g5.png")
![Enter picture description](https://images.gitee.com/uploads/images/2019/0523/094004_5964050b_345098.png "g6.png")
![Enter picture description](https://images.gitee.com/uploads/images/2019/0523/094011_048b3c7a_345098.png "g9.png")