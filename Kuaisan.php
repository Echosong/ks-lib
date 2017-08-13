<?php

namespace Echosong\Kuaisan;

class Kuaisan
{
    private function checkSumStr($numStr)
    {
        $tmp = array_count_values(str_split($numStr));
        return $tmp;
    }

    public function nextTime($currOpentime)
    {
        return strtotime("$currOpentime +9 minute");
    }

    /**
     * @param $url 获取开奖信息统一格式化一下
     */
    public function getResult($url)
    {
        $result = Http::send($url);
        if (strpos($result, 'row')) {
            $resultArr = json_decode($result, true);
            return [
                'open' => [
                    'expect' => $resultArr['open'][0]['expect'],
                    'result' => $resultArr['open'][0]['opencode'],
                    'opentime' => $resultArr['open'][0]['opentime']
                ],
                'next' => [
                    'expect' => $resultArr['open'][0]['expect'],
                    'result' => '',
                    'opentime' => $resultArr['open'][0]['opentime']
                ]
            ];
        } else {
            return [];
        }

    }

    /**
     * 投注方式 投注信息如下参数传 比如 “大 100”
    （1）  群内玩家输入上分+金额，例如：上分1000、系统审核后，才是正式玩家！
    （2） 【大10.小10.单10.双10.大单10.大双10. 小单10.小双10】这种 可识别为：大、小、单、双、大单、大双/小单小双各10 都可以识别
    （3）【1买100 或是 1/100】 这种 可识别为：1买单码。
    （4）【4和100】可识别为：和值，一共是17和
    （5）【123黑100.123/100.1234黑 100.1234/100.12345黑100.12345/100】可识别为：三码黑、四码黑、五码黑。
    （6）【112红100.112/100.112%100.1234红100.1234%100.12345%100.12345红100】可识别为：三码 红、四码红、五码红。
    （7）【包红100. %100】可识别为：包红
    （8）【1豹 100.111@100.1@100.11@100.1+100.11+100】可识别为：豹子直选
    （9） 【半顺100.半100.全顺100.全100.杂顺100.杂 100】可识别为：半顺、全顺、杂顺。
     * @param $message 投注信息
     * @return array
     */
    public function formatMessage($message)
    {
        $flg = true;
        preg_match_all('/\d+/', $message, $result);
        $numStr = "";
        $indexStr = "";
        if (count($result) > 1) {
            $money = $result[0][1];
            $numStr = $result[0][0];
        }else{
            $money = $result[0][0];
        }
        $keyword = str_replace($money, '', $message);
        $keyword = str_replace($numStr, '', $keyword);
        $indexStr = $keyword;
        if (empty($keyword)) {
            $flg = false;
        }
        if ($keyword == "/") {
            if (empty($numStr)) {
                $keyword = "红";
            }
            if (strlen($numStr) == 1) {
                $keyword = '买';
            }
            if (strlen($numStr) == 2) {
                if (substr($numStr, 0, 1) == substr($numStr, -1)) {
                    $keyword = "对";
                } else {
                    $keyword = "飞";
                }
            }
            if (strlen($numStr) >= 3) {
                $numArr = str_split($numStr);
                if ($numArr[0] == $numArr[1] and $numArr[1] == $numArr[2]) {
                    $keyword = "豹子";
                } else {
                    if (max($this->checkSumStr($numStr)) > 1) {
                        $keyword = "红";
                    } else {
                        $keyword = "黑";
                    }
                }
            }
        }
        switch ($keyword) {
            case '直':
                $indexStr = "直选";
                if (strlen($numStr) != 3) {
                    $flg = false;
                }
                break;
            case '对' :
                $indexStr = '二同号';
                if (strlen($numStr) > 2) {
                    $flg = false;
                }
                break;
            case '飞' :
                $indexStr = '二不同';
                if (strlen($numStr) != 2) {
                    $flg = false;
                }
                break;
            case '豹子':
            case '@':
            case '豹':
            case '+':
                $indexStr = '豹直选';
                if (count($this->checkSumStr($numStr)) != 1) {
                    $flg = false;
                }
                break;
            case '红':
            case '包':
            case '%':
                if (strlen($numStr) == 3) {
                    if (max($this->checkSumStr($numStr)) < 2) {
                        $flg = false;
                    }
                }
                if (empty($numStr)) {
                    $indexStr = '包红';
                } else {
                    $indexArr = [3 => "三码红", 4 => "四码红", 5 => "五码红"];
                    $indexStr = $indexArr[strlen($numStr)];
                }
                break;
            case '黑':
                $indexArr = [3 => "三码黑", 4 => "四码黑", 5 => "五码黑"];
                $indexStr = $indexArr[strlen($numStr)];
                break;
            case '买':
                $indexStr = "单买";
                if (strlen($numStr) != 1) {
                    $flg = false;
                }
                break;
            case '杂':
                $indexStr = '杂顺';
                break;
            case '全':
                $indexStr = '全顺';
                break;
            case '半':
                $indexStr = '半顺';
                break;
        }
        if (!empty($numStr)) {
            $numArr = str_split($numStr);
            for ($i = 0; $i < count($numArr); $i++) {
                if (intval($numArr[$i]) < 1 or intval($numArr[$i]) > 6) {
                    $flg = false;
                }
            }
        }
        return ['indexStr' => $indexStr, 'numStr' => $numStr, 'flg' => $flg, 'money' => $money];
    }

    /**
     * @param $game
     * @return array
     */
    public function fetchLotteryResult($game)
    {
        return [];
    }

    private function getRepeat($inpuArr)
    {
        $inputCount = array_count_values($inpuArr);
        $repateNum = null;
        foreach ($inputCount as $k => $v) {
            if ($v > 1) {
                $repateNum = $k;
                break;
            }
        }
        return $repateNum;
    }


    /**
     * @param $bettings 规则记录表（数据库表）
     * @param $bettingLog 投注编号（规则好）
     * @param $lottery 出奖结果
     * @return array
     */
    public function calcResult($bettings, $bettingLog, $lottery)
    {
        $flg = false;
        foreach ($bettings as $k => $v) {
            if ($v['id'] == $bettingLog['betting_id']) {
                $betting = $v;
                break;
            }
        }
        $rate = $betting['rate'];
        $resultArr = str_split($lottery['result'], ',');
        $resultCount = array_count_values($resultArr);
        $buyArr = str_split($bettingLog['buynum']);

        //和中奖方式
        if ($betting['code'] < 25 and $betting['code'] > 1) {
            $configArr = str_split($betting['config'], ',');
            foreach ($configArr as $c) {
                if (array_sum($resultArr) == intval($c)) {
                    $flg = true;
                }
            }
            return [$flg, floatval($rate)];
        }
        switch ($betting['code']) {
            case 1: //单买
                if (in_array($bettingLog['buynum'], $resultArr)) {
                    $count = $resultCount[$bettingLog['buynum']];
                    $rate = str_split($rate, ',')[$count - 1];
                    $flg = true;
                }
                break;
            case 25:
            case 26:
            case 27:
            case 28:
            case  29:
            case 30 : ////五码黑,五码红
                if (max($resultArr) > 1 and count($resultCount) > 1) { //结果出现重号就是红马
                    if (count($buyArr) == 3) { //三码红比较特殊
                        if ($this->getRepeat($buyArr) == $this->getRepeat($resultArr)
                            and count(array_intersect($buyArr, $resultArr)) == 3
                        ) {
                            $flg = true;
                        }
                    }
                }
                if (in_array($resultArr[0], $buyArr) and in_array($resultArr[1], $buyArr) and in_array($resultArr[2],
                        $buyArr)
                ) {
                    $flg = true;
                }
                break;
            case 31: //包红
                if (max($resultArr) > 1) {
                    $flg = true;
                }
                break;
            case 32: //二号同
                $buynum = $buyArr[0];
                if (count($buyArr) > 2) {
                    $buynum = $this->getRepeat($buynum);
                }
                if ($this->getRepeat($resultArr) == $buynum) {
                    $flg = true;
                }
                break;
            case 33: //二不同
                if (in_array($buyArr[0], $resultArr) and in_array($buyArr[1], $resultArr)) {
                    $flg = true;
                }
                break;
            case 34://直选
                if ($buyArr[0] == $resultArr[0] and $buyArr[1] == $resultArr[1] and $buyArr[2] == $resultArr[2]) {
                    $flg = true;
                }
                break;
            case 35: //豹子通
                if (count($resultCount) == 1) {
                    $flg = true;
                }
                break;
            case  36://豹直选
                if (count($resultCount) == 1 and $resultArr[0] == $buyArr[0]) {
                    $flg = true;
                }
                break;
            case 37://半顺
                if (count($resultCount) == 3) {
                    if (($resultArr[0] + 1 == $resultArr[2] and $resultArr[1] + 1 != $resultArr[2]) or
                        ($resultArr[0] + 1 != $resultArr[2] and $resultArr[1] + 1 == $resultArr[2])
                    ) {
                        $flg = true;
                    }
                }
                break;
            case 38:// 杂顺
                if (count($resultCount) == 3) {
                    if ($resultArr[0] != $resultArr[1] and $resultArr[1] != $resultArr[2]) {
                        $flg = true;
                    }
                }
                break;
            case 39://
                if ($resultArr[0] == $resultArr[1] and $resultArr[1] == $resultArr[2]) {
                    $flg = true;
                }
                break;
        }
        return [$flg, floatval($rate)];
    }
}