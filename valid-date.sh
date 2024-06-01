#!/bin/bash

# 입력값 확인
if [ $# -ne 3 ]; then
    echo "입력값 오류"
    exit 1
fi

# 변수 초기화
month=$(echo "$1" | tr '[:lower:]' '[:upper:]')
date="$2"
year="$3"
is_leap_year=0

# 월 변환 및 유효성 검사
case "$month" in
    JAN|JANUARY|1) month="Jan" ;;
    FEB|FEBRUARY|2) month="Feb" ;;
    MAR|MARCH|3) month="Mar" ;;
    APR|APRIL|4) month="Apr" ;;
    MAY|5) month="May" ;;
    JUN|JUNE|6) month="Jun" ;;
    JUL|JULY|7) month="Jul" ;;
    AUG|AUGUST|8) month="Aug" ;;
    SEP|SEPTEMBER|9) month="Sep" ;;
    OCT|OCTOBER|10) month="Oct" ;;
    NOV|NOVEMBER|11) month="Nov" ;;
    DEC|DECEMBER|12) month="Dec" ;;
    *) echo "월 입력 오류: $1은 유효하지 않습니다"
       exit 1 ;;
esac

# 윤년 계산
if [ $((year % 4)) -eq 0 ]; then
    if [ $((year % 100)) -eq 0 ]; then
        if [ $((year % 400)) -eq 0 ]; then
            is_leap_year=1
        fi
    else
        is_leap_year=1
    fi
fi

# 각 월의 일수 설정 (윤년 고려)
case "$month" in
    "Feb") max_date=$((28 + is_leap_year)) ;;
    "Apr"|"Jun"|"Sep"|"Nov") max_date=30 ;;
    *) max_date=31 ;;
esac

# 날짜 유효성 검사
if ! [[ "$date" =~ ^[0-9]+$ ]] || [ "$date" -lt 1 ] || [ "$date" -gt "$max_date" ]; then
    # 윤년 여부에 따른 오류 메시지 출력
    if [ "$month" == "Feb" ] && [ "$date" -eq 29 ] && [ "$is_leap_year" -eq 0 ]; then
        echo "윤년이 아닙니다: $month $date $year은 유효하지 않습니다"
    else
        echo "날짜 입력 오류: $month $date $year은 유효하지 않습니다"
    fi
    exit 1
else
    # 유효한 날짜 출력 및 윤년 여부 출력
    echo "$month $date $year"
    if [ "$is_leap_year" -eq 1 ]; then
        echo "윤년입니다."
    else
        echo "윤년이 아닙니다."
    fi
fi
