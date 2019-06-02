import urllib.request as ul
import json
from datetime import  datetime, timedelta
import cx_Oracle

try:
    conn = cx_Oracle.connect('madang/1234@localhost:1521/xe')
    cur = conn.cursor()
    print("연결 성공")
except:
    print("연결 실패")
sql = 'delete from boxoffice10'
try:
    cur.execute(sql)
    conn.commit()
    print('초기화 성공')
except Exception as e:
    print('초기화 실패: {}'.format())
sql = 'insert into boxoffice10 values(:1, :2,:3,:4)'
url="http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=df586b0594659914b9421978f0576b67&targetDt="
date = (datetime.today() - timedelta(1)).strftime("%Y%m%d")
# print(date)
url = url + (str)(date)
request = ul.Request(url)
response = ul.urlopen(request)
rescode = response.getcode()
if(rescode == 200):
    responseData = response.read()
result = json.loads(responseData)['boxOfficeResult']['dailyBoxOfficeList']
for i, top in enumerate(result):
    tmp =[top['rank'], top['rankOldAndNew'], top['movieNm'], top['audiChange']]
    try:
        cur.execute(sql, tuple(tmp))
        conn.commit()
        print('{}번째 성공'.format(i+1))
    except Exception as e:
        print("{}번째 실패: {}".format(i+1,e))
cur.close()