import { read } from '../utils.ts';

async function adventurDay3Part1 () {
  let sum = 0;

  const contents = await read('day3/input3.txt');
  const re = /mul\([\d{1,3}]+\)/gi;

  const res = contents.matchAll(re);

  for (let match of res) {
    sum += eval(match[0].replaceAll(/(,)|[^\d]+/gi, '$1').replace(',', '*'));
  }

  console.log('total:', sum);
}

// Uncomment to run part 1
// adventurDay3Part1();

async function adventurDay3Part2 () {
  const contents = await read('day3/input4.txt');
  // const contents = "+mul(900,640)%*{why()?from()mul(750,181)]{%;]mul(771,902)<>$]how());,mul(646,610)why()mul(644,958)[/{<*)mul(490,14)/where()why()::where()${+?mul(524,278)when()mul(609,995){*(,how()(where(18,555)-who()mul(456,815)do()[$:~(}@mul(987,108)<select()who(),>}@>when()<mul(561,928)}$how(984,377)+:what(){ %]mul(242,236)mul(401,270)mul(144@who(){from()-[mul(850,190)& #where()@^/'>mul(511,942)select()$(/<mul(404,904)<^when()'how()[when()$}}mul(891,878)mul(381,288)<+[[<from()who()-mul(282,737),who(){what()-!>mul(60,709)(mul(291?}where(670,848)who()@from()',mul(890,902)[){,&%}%mul(539,945)%$~what()do()#what()how(931,606)!,',what()mul(175,630)]@-&when(98,693)$when()when()mul(850,996~;:@who()<^}/'mul(103,549)how(482,381);when()mul(408,760)where()!mul(796,714)&^]}mul(557,352)how()+{+]select()mul(135,816)?##@<mul(812,707)(^^what()%&$]mul(305,996) ?what()[mul(19,420)~{;mul(451<who()mul(678,132)!:]select();'select(414,538)-what()@mul(775,858)+'{ :[mul(151,737)*mul(305,447)?+<mul(773,348)*% ~}!>+do()@;from()%(mul(571,910)don't()?)%^+%mul(738,321)who()>&-?what()don't(){[?why()who()mul(558,221)}${!'(+*who()do())how();#<>?<mul(824where()mul(351,367)#/ :how()mul(212,77)}<]]mul(769,809)#when(303,117)select()(<':!%(mul(126,148)]why()%[^why()where()]mul(288,573)~@]>%'why()>)mul(850,160);~[select() why()why()~;mul(276,634) +{mul(615,507):when()++#:mul(817,325??(mul(748,223)^<!&^] &/mul(755,745)&:!&who()]-#;,mul(674,378)why()&}-how(667,459)( mul(688,272)'<who()~do()mul(608,206)~$^:'*)?*mul(47,323)mul(612,590)({how()mul(966,673)'(from()where()who()mul(802,18)mul(8,840))how()'^#[}(mul(588,513)(<[;when())) how()don't())who(97,403)mul(642,367)where()when()who(),why()from()'mul(333,247)+[where()-]+*mul(7,926)^!where()%#where(109,801)mul(247,920)+}-&]select()select(878,420)#mul'{::what()how() mul(281,809)~/,from()/+^how()@>mul(67,325)mul(10,782)@";
  // const contents = "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))";

  const re = /do\(\)|mul\([\d{1,3}]+\)|don't\(\)/gi;

  const mulRegex = /(,)|[^\d]+/gi;

  const custom = `do()${contents}`
  const res = custom.matchAll(re);

  let enabled = false;
  let sum = 0;

  for (let match of res) {
    if (match[0] === 'do()') enabled = true
    else if (match[0] === 'don\'t()') enabled = false;
    else if (enabled) {
      sum += eval(match[0].replaceAll(mulRegex, '$1').replace(',', '*'));
    }
  }

  // 74361272
  console.log('total:', sum);
}

// Uncomment to run part 2
// adventurDay3Part2();