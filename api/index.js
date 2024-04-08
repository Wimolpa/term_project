const express = require('express')
const cors = require('cors')
const app = express();
app.use(express.json());
app.use(cors());

const mockUser = [
    {
        id :1,
        username:'admin',
        password:'123456',
        comment:[
            {
            cid :1,
            pid :1,
            content:'ใช้ดีมาก',
        },
            {
            cid :2,
            pid :1,
            content:'ลดรอยดีมาก',
        }
    ]
    },
    {
        id :2,
        username:'admin1',
        password:'12345a',
        comment:[{
            cid :1,
            pid :2,
            content:'แพ้',
        }]
    },
    {
        id :3,
        username:'t',
        password:'t',
        comment:[{
            cid :1,
            pid :3,
            content:'ใช้ดี',
        }]
    }
]


const product =[
    {
        pid :1,
        itemname :'p1',
        price : 250,
        image:'https://smooth-e.com/wp-content/uploads/2022/12/smecreamAW1.jpg',
        description :''
    }
]

app.get('/product', function (req, res) {
    res.send(product);
});
app.post('/product', function (req, res) {
    const {itemname,price,image,description} = req.body;
    const pid = product.length + 1;
    if(itemname === '' || price === '' || image === ''){
        res.status(401).send({err:'Unauthorized'});
    }else{
        if(!product.find(p => p.itemname === itemname)){
            product.push({pid,itemname,price,image,description});
            res.send({product});
        }
        else{
            res.status(200).send({err:'Already Exist'});
        }
    }
    
    
})

app.get('/comment', function (req, res) {
    res.send(mockUser);
});
app.post('/comment', function (req, res) {
    const {id,pid,content} = req.body;
    const cid = mockUser[id-1].comment.length + 1;
    if(content === ''){
        res.status(401).send({err:'Unauthorized'});
    }else{
        mockUser[id-1].comment.push({cid,pid,content});
        res.send({mockUser});
    }
    
    
})

app.get('/', function (req, res) {
    res.send('Hello World')
});

app.post('/login', function (req, res) {
    const {username,password} = req.body;
    const user = mockUser.find(u => u.username === username && u.password === password);
    if(user){
        res.status(200).send({ success:true, user});
    }else{
        res.status(401).send({err:'Unauthorized'});
    }
});



app.listen(3000)

