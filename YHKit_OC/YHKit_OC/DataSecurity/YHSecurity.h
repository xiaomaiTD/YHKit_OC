



/*
 数据安全
 
 
 
 
 
                           |------|        /-----        ---
                           |      |       /             /   \
                           |      |       \            /     \
                           |------|        \          /-------\
                           |     \          |        /         \
                           |      \         /       /           \
                           |       \  -----/       /             \
 
 
 
 
 RSA加密一般会被用在网银类App中.虽然网银会采用全站https方案, 但是在安全登录这块会使用另一个证书对登录信息加密, 这样可以双层确保数据安全.
 基于RSA加密解密算法, 还可以将其运用在数字签名场景.
 
 使用openssl工具生成RSA证书，此处分为两种，一种是生成文件格式，做法是把公钥私钥文件拖进工程中；还有一种做法是获取公钥私钥内容
 
 ==============================生成文件，把文件拖进工程中================================
 ==> 1、生成模长为1024bit的私钥文件private_key.pem(这一步生成的私钥文件编码是PKCS#1格式)如果为了更安全，可以生成2048位的(openssl genrsa -out private_key.pem 2048)
 openssl genrsa -out private_key.pem 1024
 
 ==> 2、生成证书请求文件rsaCertReq.csr
 注意：这一步会提示输入国家、省份、mail等信息，可以根据实际情况填写，或者全部不用填写，直接全部敲回车.
 openssl req -new -key private_key.pem -out rsaCerReq.csr
 
 ==> 3、生成证书rsaCert.crt，并设置有效时间为1年
 openssl x509 -req -days 3650 -in rsaCerReq.csr -signkey private_key.pem -out rsaCert.crt
 
 ==> 4、生成供iOS使用的公钥文件public_key.der
 openssl x509 -outform der -in rsaCert.crt -out public_key.der
 
 ==> 5、生成供iOS使用的私钥文件private_key.p12
 注意：这一步会提示给私钥文件设置密码，直接输入想要设置密码即可，然后敲回车，然后再验证刚才设置的密码，再次输入密码，然后敲回车，完毕！
 在解密时，private_key.p12文件需要和这里设置的密码配合使用，因此需要牢记此密码.
 openssl pkcs12 -export -out private_key.p12 -inkey private_key.pem -in rsaCert.crt
 
 ==> 6、生成供Java使用的公钥rsa_public_key.pem
 openssl rsa -in private_key.pem -out rsa_public_key.pem -pubout
 
 ==> 7、生成供Java使用的私钥pkcs8_private_key.pem
 openssl pkcs8 -topk8 -in private_key.pem -out pkcs8_private_key.pem -nocrypt
 
 
 ==============================获取公钥、私钥内容================================
 ==> 生成私钥(这一步和上面的第一步相同)
 openssl genrsa -out rsa_private_key.pem 1024
 ==> 根据私钥生成公钥(和上面的第6步相同)
 openssl rsa -in rsa_private_key.pem -out rsa_public_key.pem -pubout
 ==> 把私钥转换成PKCS#8编码(和上面的第7步相同)
 openssl pkcs8 -topk8 -in rsa_private_key.pem -out pkcs8_rsa_private_key.pem -nocrypt
 
 测试之后发现，私钥必须是PKCS#8编码的才能解密，用PKCS#1格式的不能解密。网上找了很多资料，都说iOS一般用的是PKCS#1编码的。这是怎么回事?
 
 公钥可以用于加密，那么就必须用对应的私钥进行解密
 私钥也可以用于加密，但必须用公钥进行解密
 
 RSA讲解：https://www.zhihu.com/question/25912483
 RSA加密/解密和签名/验签:https://www.jianshu.com/p/8dc4a5f64e06
 如果用于加密解密，那就是用公钥加密私钥解密（仅你可读但别人不可读，任何人都可写）
 如果用于证书验证，那就是用私钥加密公钥解密（仅你可写但别人不可写，任何人都可读）
 最后，RSA的公钥、私钥是互相对应的。RSA会生成两个密钥，你可以把任何一个用于公钥，然后另一个就是你必须保护好的私钥了
 
 对加密/解密和签名/验签完整过程详细理解:
 A->B:
 1. A提取消息m的消息摘要h(m),并使用自己的私钥对摘要h(m)进行加密,生成签名s
 2. A将签名s和消息m一起,使用B的公钥进行加密,生成密文c,发送给B
 
 B:
 1. B接收到密文c,使用自己的私钥解密c得到明文m和数字签名s
 2. B使用A的公钥解密数字签名s解密得到H(m)
 3. B使用相同的方法提取消息m的消息摘要h(m)
 4. B比较两个消息摘要。相同则验证成功;不同则验证失败
 
 
 
 
 */


#import <Foundation/Foundation.h>


@interface YHSecurity : NSObject

#pragma mark - RSA
/** 加密/解密 */
+ (NSString *)encryptString:(NSString *)str publicKey:(NSString *)pubKey;
+ (NSData *)encryptData:(NSData *)data publicKey:(NSString *)pubKey;
+ (NSString *)decryptString:(NSString *)str privateKey:(NSString *)privKey;//解密返回的数据就是原始数据，不是经过base64的
+ (NSData *)decryptData:(NSData *)data privateKey:(NSString *)privKey;
/** 签名/验签 */
+ (NSString *)encryptString:(NSString *)str privateKey:(NSString *)privKey;
+ (NSData *)encryptData:(NSData *)data privateKey:(NSString *)privKey;
+ (NSString *)decryptString:(NSString *)str publicKey:(NSString *)pubKey;//解签返回的数据就是原始数据，不是经过base64的
+ (NSData *)decryptData:(NSData *)data publicKey:(NSString *)pubKey;
#pragma mark - MD5

#pragma mark - AES

#pragma mark - base64
+ (NSString *)base64EncodeWithData:(NSData *)data;
+ (NSData *)base64DecodeWithString:(NSString *)str;


@end














