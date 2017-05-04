def get_blk_list():
    blk_list = []
    with open('LA_Blocks.csv','r') as fr:
        fr.readline()
        for line in fr:
            xx = line.split(',')
            blkid = xx[5]
            blk_list.append(blkid)
    return blk_list

def get_pro(filename):
    temp_dic = {}
    with open(filename,'r') as fr:
        fr.readline()
        for line in fr:
            xx = line.strip().split(',')
            blk, pro = xx[0], xx[1]
            temp_dic[blk] = pro
    return temp_dic

blk_list = get_blk_list()
la_home = get_pro('LAjoin_home.csv')
la_work = get_pro('LAjoin_work.csv')
la_home_user = get_pro('LAjoin_home_user.csv')
la_work_user = get_pro('LAjoin_work_user.csv')

with open('LA_twitter_stat.csv','w') as fw:
    fw.write('geoid,home_tweets,home_users,work_tweets,work_users\n')
    for blk in blk_list:
        ht, hu, wt, wu = '0', '0', '0', '0'
        if blk in la_home:
            ht = la_home[blk]
        if blk in la_home_user:
            hu = la_home_user[blk]
        if blk in la_work:
            wt = la_work[blk]
        if blk in la_work_user:
            wu = la_work_user[blk]
        nl = '="' + blk + '",' + ht + ',' + hu + ',' + wt + ',' + wu + '\n'
        fw.write(nl)
