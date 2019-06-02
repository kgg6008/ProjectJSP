import requests
from bs4 import BeautifulSoup
import cx_Oracle
from movieInfoCrawler import movieInfoCrawler as mc
import re
url = "https://movie.naver.com/movie/running/current.nhn"
response = requests.get(url)
bs = BeautifulSoup(response.text, 'html.parser')
body = bs.body
target = body.find(class_= "lst_detail_t1")
movie=target.find_all('li')
rank = 1
try:
    conn = cx_          Oracle.connect('madang/1234@localhost:1521/xe')
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
    print('초기화 실패: {}'.format(e))
sql = 'insert into nowplaying values(:1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11)'

for info in movie:
    tmp_list = []
    #등수
    tmp_list.append(rank)
    #이미지
    try:
        tmp_img = info.find(class_="thumb").find_all("img")[0].get("src")
        tmp_img = tmp_img[:tmp_img.find('?')]
    except:
        tmp_img = None
    tmp_list.append(tmp_img)
    #제목, 링크
    tmp = info.find(class_="tit").find('a')
    tmp_title = tmp.text
    tmp_link = "https://movie.naver.com" + tmp.get("href")
    moviecd = tmp.get("href")
    moviecd = moviecd[moviecd.find('=')+1:]
    print(moviecd)
    crawler = mc(tmp_link)
    crawler.find_info()
    crawler.update_db()
    tmp_list.append(tmp_title)

    #예매율
    try:
        tmp = info.find(class_="star_t1 b_star").find_all('span')
        tmp_rate = " ".join([string.text.strip() for string in tmp])
    except:
        tmp_rate = "정보 없음"
    tmp_list.append(tmp_rate)
    #연령정보
    try:
        tmp_ageR = info.find(class_="tit").find("span").text
    except:
        tmp_ageR = "정보 없음"
    tmp_list.append(tmp_ageR)
    #장르
    try:
        tmp = info.find(class_="link_txt").find_all("a")
        # print(tmp)
        tmp_genre = [tmp2.text.strip() for tmp2 in tmp]
        tmp_genre = ", ".join(tmp_genre)
    except:
        tmp_genre = "정보 없음"
    tmp_list.append(tmp_genre)
    #상영시간, 개봉일자
    try:
        tmp = info.find(class_="info_txt1").find("dd").text
        tmp =" ".join(tmp.split())
        # print(tmp)
        reEST = re.compile(r'\d*분')
        reReleaseD = re.compile(r"\d{4}\.\d{2}\.\d{2}")
        tmpShowTime = reEST.findall(tmp)[0]
        tmpReleaseDate = reReleaseD.findall(tmp)[0]
    except:
        tmpShowTime = "정보 없음"
        tmpReleaseDate = None
    tmp_list.append(tmpShowTime)
    tmp_list.append(tmpReleaseDate)
    #감독
    try:
        tmp = info.find(class_="info_txt1").find_all('dd')[1].find('span').find_all('a')
        tmpDirector = ", ".join([name.text.strip() for name in tmp])
    except:
        tmpDirector = "정보 없음"
    tmp_list.append(tmpDirector)
    try:
        tmp = info.find(class_="info_txt1").find_all('dd')[2].find(class_="link_txt").find_all('a')
        tmpActor = ", ".join([name.text.strip() for name in tmp])
    except:
        tmpActor = "정보 없음"
    tmp_list.append(tmpActor)
    tmp_list.append(moviecd)
    try:
        cur.execute(sql, tuple(tmp_list))
        conn.commit()
        print('{}번째 성공'.format(rank))
    except Exception as e:
        print("{}번째 실패: {}".format(rank, e))
    rank += 1

cur.close()



