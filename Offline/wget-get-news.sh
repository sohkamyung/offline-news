#! /bin/bash
### timeout=60
timeout=30
maxLevel=1
waitTime=2
# for silly sites like Economist.com
# userAgent="Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.12"
userAgent="Mozilla/5.0 (Linux; Android 4.0.4; Galaxy Nexus Build/IMM76B) AppleWebKit/535.19 (KHTML, like Gecko) Chrome/18.0.1025.133 Safari/535.19"

acceptList="lwn.css,layout.css.gzip,style.css.gzip"

#natureRejectList="spn-printable-hd.gif,facebook.gif,icon-newsvine.gif,icon-delicious.gif,icon-twitter.gif,pull-belt.gif,pull-hat.gif,pull-socks.gif,icon-sideline-robot.gif,icon-sideline-score.gif,icon-sideline-zoo.gif,icon-sideline-blank.gif,icon-sideline-scoresame.gif,icon-sideline-scoreup.gif,icon-sideline-scoredown.gif,icon-sideline-showbiz.gif,bg-yellowtowhite.gif,icon-yahoo.gif,icon-pdf.gif,icon-friend.gif,icon-reprints.gif,icon-sideline-datapoint.gif,icon-sideline-onrecord.gif,icon-sideline-number.gif,icon-sideline-overhyped.gificon-sideline-wordwatch.gificon-n.gif,example-special-latest-news.jpg,opinion-header.gif,opinion-editorials.gif,arrow-red-down.gif,arrow-bullet.gif,news-elsewhere.gif,nature-reports.gif,sci-american.gif,more-arrow.gif,seperator.gif,spotlight.gif,toolsheader.gif,icon-fulltext.gif,icon-feed.gif,icon-connectea.gif,nav_dots2.gif,nav_dots1.gif,arrow_white_up.gif,arrow_grey.gif,arrow_blue.gif,next.gif,next_hover.gif,arrow_blue_left.gif,powerpoint.gif,jotw.gif,eotm.gif,tab_r_blue.gif,arrow_s.gif,tab_1_blue.gif,icon-rss.gif,end-of-item.gif,heading_icon_hot.jpg,heading_icon_cal.jpg,heading_icon_news.jpg,heading_icon_opinion.jpg"

rejectList="oasisi.php*,*adview.php*,pagenavi-css.css,js,ico,spacer.gif,Spacer.gif,black.gif,advt-*.gif,nslogo*.gif,iconpremium.gif,iconarrow.gif,logo.gif,bClose.gif,bottom.gif,lbCorner.gif,rbCorner.gif,*advertisement.gif,cached.gif*,notCached.gif*,header_advertise_*.gif,news-blog.gif,ams.jpg,mt-scode.cgi*,bulletPoint.jpg,b.png,tl.png,tr.png,bl.png,br.png,icon_searcharrow.jpg,nv_hdnav_keybg.jpg,ad_bg.gif,bxhd*.jpg,skcoverbg_*.jpg,ftlogin_*.jpg,hdlogin_*.jpg, tab_*.gif,reg*.jpg,next*.jpg,tagcloud_*.jpg,summ_*.gif,tags*.jpg,cat_*.gif,bg_*.gif,icon_*.gif,tab_*.gif,bg_*.gif,comment_*.gif,nav_*.gif,arrow_*.gif,gradient_*.jpg,heading_*.jpg,button-*.gif,technorati-*.png,button-*.gif,shim-*.gif,bullet-*.gif,icon-*.gif,pull-*.gif,example-*.jpg,more-*.gif,nature-*.gif,bg-*.gif,mt-nv_*.jpg,snv_*.jpg,boxtsr2x1_*.gif,bg_register_*.png,login_*.gif,threed_*.gif,pdb_*.gif,opinion-*.gif,arrow-*.gif,registration-*.gif,reg-*.gif,nature-networks-*.jpg,nature.com.*.gif,newsbeyond_*.jpg"

#rejectDirs="/news/images,/ec_ads"
rejectDirs="/sites/all/modules/ec_ads"

acceptdomainList="localhost,lwn.net,66.240.198.75,news.bbc.co.uk,news.bbcimg.co.uk,newsimg.bbc.co.uk,images.bwbx.io,images.businessweek.com,res.businessweek.com,www.businessweek.com,news.businessweek.com,mobile.businessweek.com,static.btrd.net,economist.com,technology.newscientist.com,environment.newscientist.com,space.newscientist.com,www.newscientist.com,www.newscientistspace.com,www.newscientisttech.com,www.technologyreview.com,www.universetoday.com,rackspacecloud.com,www.washingtonpost.com,live.washingtonpost.com,blogs.nature.com,www.nature.com,www.sciencenews.org,1-ps.googleusercontent.com,ut-images.s3.amazonaws.com,www.flickr.com,twitter.com,www.astroturf.com,legault.perso.sfr.fr,cloudfront.net,bwbx.io"

wget --no-http-keep-alive --no-check-certificate --restrict-file-names="windows,nocontrol" --timeout=${timeout} --user-agent="${userAgent}" --wait=${waitTime} --random-wait -e robots=off -H --html-extension --timestamping -r -l ${maxLevel} -p -k --domains=${acceptdomainList} --reject="${rejectList}" --exclude-directories="${rejectDirs}" "http://localhost/news.html"
