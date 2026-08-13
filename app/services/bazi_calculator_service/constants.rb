# frozen_string_literal: true

class BaziCalculatorService
  # Data constants for BaZi calculations (stems, branches, kua directions)
  module Constants
    STEMS = [
      { en: 'Jia Wood', zh: '甲木', element: 'Wood', polarity: 'Yang' },
      { en: 'Yi Wood', zh: '乙木', element: 'Wood', polarity: 'Yin' },
      { en: 'Bing Fire', zh: '丙火', element: 'Fire', polarity: 'Yang' },
      { en: 'Ding Fire', zh: '丁火', element: 'Fire', polarity: 'Yin' },
      { en: 'Wu Earth', zh: '戊土', element: 'Earth', polarity: 'Yang' },
      { en: 'Ji Earth', zh: '己土', element: 'Earth', polarity: 'Yin' },
      { en: 'Geng Metal', zh: '庚金', element: 'Metal', polarity: 'Yang' },
      { en: 'Xin Metal', zh: '辛金', element: 'Metal', polarity: 'Yin' },
      { en: 'Ren Water', zh: '壬水', element: 'Water', polarity: 'Yang' },
      { en: 'Gui Water', zh: '癸水', element: 'Water', polarity: 'Yin' }
    ].freeze

    BRANCHES = [
      { en: 'Zi Rat', zh: '子鼠', animal: 'Rat', element: 'Water', double_hour: '23:00 - 00:59' },
      { en: 'Chou Ox', zh: '丑牛', animal: 'Ox', element: 'Earth', double_hour: '01:00 - 02:59' },
      { en: 'Yin Tiger', zh: '寅虎', animal: 'Tiger', element: 'Wood', double_hour: '03:00 - 04:59' },
      { en: 'Mao Rabbit', zh: '卯兔', animal: 'Rabbit', element: 'Wood', double_hour: '05:00 - 06:59' },
      { en: 'Chen Dragon', zh: '辰龙', animal: 'Dragon', element: 'Earth', double_hour: '07:00 - 08:59' },
      { en: 'Si Snake', zh: '巳蛇', animal: 'Snake', element: 'Fire', double_hour: '09:00 - 10:59' },
      { en: 'Wu Horse', zh: '午马', animal: 'Horse', element: 'Fire', double_hour: '11:00 - 12:59' },
      { en: 'Wei Goat', zh: '未羊', animal: 'Goat', element: 'Earth', double_hour: '13:00 - 14:59' },
      { en: 'Shen Monkey', zh: '申猴', animal: 'Monkey', element: 'Metal', double_hour: '15:00 - 16:59' },
      { en: 'You Rooster', zh: '酉鸡', animal: 'Rooster', element: 'Metal', double_hour: '17:00 - 18:59' },
      { en: 'Xu Dog', zh: '戌狗', animal: 'Dog', element: 'Earth', double_hour: '19:00 - 20:59' },
      { en: 'Hai Pig', zh: '亥猪', animal: 'Pig', element: 'Water', double_hour: '21:00 - 22:59' }
    ].freeze

    KUA_DIRECTIONS = {
      1 => { group: 'East', sheng_qi: 'SE', tian_yi: 'E', yan_nian: 'S', fu_wei: 'N' },
      2 => { group: 'West', sheng_qi: 'NE', tian_yi: 'W', yan_nian: 'NW', fu_wei: 'SW' },
      3 => { group: 'East', sheng_qi: 'S', tian_yi: 'N', yan_nian: 'SE', fu_wei: 'E' },
      4 => { group: 'East', sheng_qi: 'N', tian_yi: 'S', yan_nian: 'E', fu_wei: 'SE' },
      6 => { group: 'West', sheng_qi: 'W', tian_yi: 'NE', yan_nian: 'SW', fu_wei: 'NW' },
      7 => { group: 'West', sheng_qi: 'NW', tian_yi: 'SW', yan_nian: 'NE', fu_wei: 'W' },
      8 => { group: 'West', sheng_qi: 'SW', tian_yi: 'NW', yan_nian: 'W', fu_wei: 'NE' },
      9 => { group: 'East', sheng_qi: 'E', tian_yi: 'SE', yan_nian: 'N', fu_wei: 'S' }
    }.freeze
  end
end
