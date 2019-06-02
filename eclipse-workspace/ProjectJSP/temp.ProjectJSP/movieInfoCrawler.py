import pandas as pd
import requests
from bs4 import BeautifulSoup
import cx_Oracle
from datetime import  datetime, timedelta
class movieInfoCrawler():
    def __init__(self, url):
        self.url = url
        self.response = requests.get(self.url)
        self.bs = BeautifulSoup(self.response.text, 'html.parser')
        self.target = self.bs.body.find('div', {'class':'article'})
        try:
            self.conn = cx_Oracle.connect('madang/1234@localhost:1521/xe')
            self.cur = self.conn.cursor()
        except:
            print("연결 실패")

    def find_info(self):
        #영화 코드. 제목 찾기
        movieCd = self.target.find('h3', {'class': 'h_movie'}).find('a').get('href')
        movieCd = movieCd[movieCd.find('=') + 1:]
        title = self.target.find('h3', {'class': 'h_movie'}).find('a').text
        # print("영화 코드 : {}".format(movieCd))
        # print("영화 제목 : {}".format(title))
        #평점(관람객, 기자 평론가, 네티즌 순)
        starList =[]
        star = self.target.find_all('span', {'class': 'st_on'})
        for i, star_i in enumerate(star):
            if(i > 2):
                # 3가지만 받을 것이므로
                break;
            try:
                tmp_star = star_i.get('style')
                tmp_star = str(round(float(tmp_star[tmp_star.find(':')+1:tmp_star.find('%')])/10, 2))
            except:
                tmp_star = "정보 없음"
            starList.append(tmp_star)
        # print(starList)
        #info_movie teg 저장
        info_movie = self.target.find('dl', {'class': 'info_spec'}).find_all('dd')
        #info list([장르, 개봉 국가, 상영시간, 개봉일, 감독, 출연, 등급])
        info_list =[]
        for i,info_i in enumerate(info_movie):
            if i > 3:
                break;
            tmp = info_i.find('p')
            if i == 0:
                span = tmp.find_all('span')
                for span_i in span:
                    try:
                        info_list.append(" ".join(span_i.text.split()))
                    except:
                        info_list.append('정보 없음')
            else:
                try:
                    tmp = ' '.join(tmp.text.split())
                    if len(tmp) != 0:
                        info_list.append(tmp)
                    else:
                        info_list.append('정보 없음')
                except:
                    info_list.append('정보 없음')
        # print(info_list)
        #포스터 링크
        poster = self.target.find('div', {'class': 'poster'}).find('img').get('src')
        poster=poster[:poster.find('?')]
        # print("포스터 링크: {}".format(poster))
        #줄거리
        try:
            summary = self.target.find('p', {'class': 'con_tx'}).text.replace(u'\xa0', ' ')
        except:
            summary = '정보 없음'
        # print(summary)

        #배우 url
        actor = "https://movie.naver.com/movie/bi/mi/detail.nhn?code="+movieCd
        # print("배우: {}".format(actor))
        photo = "https://movie.naver.com/movie/bi/mi/photoView.nhn?code="+movieCd
        # print("사진: {}".format(photo))
        video = "https://movie.naver.com/movie/bi/mi/media.nhn?code="+movieCd
        # print("동영상: {}".format(video))
        #전체
        self.total = [movieCd] + [title] + starList + info_list + [poster] + [summary]  + [actor] + [photo] + [video]


    def update_db(self):
            try:
                sql = "INSERT INTO MOVIEINFO(moviecd, name, gradeaud, graderep, gradenet, genre, country," \
                    "runtime, rdate, director, actor, agegrade, poster, summary, actorurl, photourl, videourl)" \
                    "VALUES (:1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15, :16, :17)"
                self.cur.execute(sql, tuple(self.total))
                self.conn.commit()
                self.cur.close()
            except Exception as e:
                print("{} 실패".format(e))


"""
if __name__ == '__main__':

    url = "https://movie.naver.com/movie/sdb/rank/rmovie.nhn?sel=cnt&date="
    date = (datetime.today() - timedelta(1)).strftime("%Y%m%d")
    url = url + date
    basic_url = "https://movie.naver.com/"
    response = requests.get(url)
    bs = BeautifulSoup(response.text, 'html.parser')
    target = bs.body.find_all(class_="list_ranking")

    for target_info in target:
        movie = target_info.find_all('div', {'class': 'tit3'})
        for i, urls in enumerate(movie):
            urls = urls.find('a')
            print("{}번 째 저장".format(i+1))
            tmp_url = basic_url + urls.get("href")
            tmpMovie = movieInfoCrawler(tmp_url)
            tmpMovie.find_info()
            tmpMovie.update_db()

"""
