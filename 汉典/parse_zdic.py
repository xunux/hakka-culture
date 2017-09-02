#!/bin/python
# coding=utf-8

import json
import re

from operator import itemgetter, attrgetter

hakpin_pattern = re.compile('[^a-zA-Z]')
dict_set = set()
hakka_dict_list = []
hakka_fongyan_dic = {}
yueyu_dic_list = []
fout = open("zdic_hakka.yaml", 'w', encoding='utf8')
f = open("zdic.json")
rs = json.load(f, encoding='utf8')
counter = 0

for word_dict in rs:
    # print(word_dict)
    if 'hakka' in word_dict:
        zii = word_dict['name']
        content = word_dict['hakka'].strip('◎ 客家话：')
        # print(content)
        speakings = content.split(' ')
        # print(speakings)
        pinyin_dic = {}
        for col in speakings:
            if not col.strip():
                continue
            if col.startswith('['):
                speak_name = col[1:-1]
            else:
                # print(col)
                pinyin = hakpin_pattern.sub('', col)
                # print(pinyin)
                if not pinyin:
                    continue
                if pinyin in pinyin_dic:
                    pinyin_dic[pinyin] += 1
                else:
                    pinyin_dic[pinyin] = 1
        # pinyins = [(k, v) for k, v in pinyin_dic.items()]
        pinyins = list(zip(pinyin_dic.keys(), pinyin_dic.values()))
        pinyins.sort(key=lambda x: x[1], reverse=True)
        # print(pinyins)

        for kv in pinyins[0:4]:
            # if kv[1] <= 1:
            #     continue
            hakka_dict_list.append((zii, kv[0], kv[1]))
        # print(hakka_dict_list)
    counter += 1
    # break

# 先降序 后升序
# 或者 一个字一个字按频次降序排序好，然后最后总的按字自然升序
# hakka_dict_list.sort(key=lambda x: x[2], reverse=True)
# hakka_dict_list.sort(key=lambda x: x[0])
hakka_dict_list.sort(key=lambda x: x[0])

print(counter)
for zii_yin in hakka_dict_list:
    fout.write('\t'.join([zii_yin[0], zii_yin[1]]) + '\n')
fout.close()

# print(word_list)
# print(vocabulary_list)
