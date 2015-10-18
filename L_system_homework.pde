class LRule {
 String cur;
 String GoTo;
 
 public LRule() {}
 
 String GetId() {
  return cur; 
 }
 
 LRule(String c, String gt) {
   cur = c;
   GoTo = gt; 
 }
 
 String GetNext() {
   return GoTo;
 }
 
}

class StochLRule extends LRule {
 String cur;
 String[] GoTos;

 String GetId() {
  return cur; 
 }

 StochLRule(String c, String[] Gt) {
  cur = c;
  GoTos = Gt;
  println(cur);
 } 
 
 String GetNext() {
  return GoTos[(int)(random(0,GoTos.length))]; 
 }
 
}

class LSystem {
 void DrawChar(char c,int len) {}
}


LRule FindRule(String at, ArrayList<LRule> rules) {
  for (LRule rule : rules) {
    if (rule.GetId().equals(at)) return rule;
  }
  return (new LRule(at,at));
}

String NextL(String cur, ArrayList<LRule> rules) {
  String ret = "";
  for (int j = 0;j < cur.length();++j) {
     char i = cur.charAt(j);
     String it = "" + i;
     LRule rule = FindRule(it,rules);
     ret += rule.GetNext();    
  }
  return ret;
}

void DrawL(String L, LSystem system,int len) {
 for (int j = 0;j < L.length();++j) {
   system.DrawChar(L.charAt(j),len); 
 }
}
int ang = 25;
class DragonExtend extends LSystem {
 void DrawChar(char c, int len) {
  if (c == 'F') {
     line(0,0,0,-len);
     translate(0,-len); 
  } else if (c == '+') {
     rotate(ang * PI / 180); 
  } else if (c == '-') {
     rotate(- ang * PI / 180); 
  } else if (c == '[') {
     pushMatrix();
  } else if (c == ']') {
     popMatrix();
  }
 } 
}

int seed = 0;
void DrawCrazyTree(int num) {
  fill(0);
  stroke(0);
  randomSeed(seed);
  ArrayList<LRule> rules = new ArrayList<LRule>();
  String[] pos = {"FF-F--F-F","F-F--F-FF","FF+F++F+F","F+F++F+FF","FF--FF++FF","F"};
  rules.add(new StochLRule("F", pos));
  String[] pos_1 = {"-","+","+"};
  rules.add(new StochLRule("+",pos_1));
  pos_1[1] = "-";
  rules.add(new StochLRule("-",pos_1));
  String next = "FFF-FFF+FFF";
  for (int i = 0;i < num;++i) next = NextL(next,rules);
  println(next);
  DragonExtend dre = new DragonExtend();
  translate(width / 2, height / 2 );
  DrawL(next,dre,2);
  noLoop();
}

class FreeGroup extends LSystem {
 void DrawChar(char c, int len) {
   if (c == 'L') {
     line(0,0,-len,0);
     translate(-len,0);
     stroke(255,0,0);
   } else if (c == 'R') {
     line(0,0,len,0);
     translate(len,0);
     stroke(255,0,0); 
   } else if (c == 'U') {
     line(0,0,0,len);
     translate(0,len);
     stroke(0,0,255);
   } else if (c == 'D') {
     line(0,0,0,-len);
     translate(0,-len);
     stroke(0,0,255); 
   } else if (c == '[') {
     pushMatrix();
  } else if (c == ']') {
     popMatrix();
  }
 } 
}

void DrawFree(int num) {
  fill(0);
  stroke(0);
  ArrayList<LRule> rules = new ArrayList<LRule>();
  rules.add(new LRule("a","[L[LabB]]"));
  rules.add(new LRule("A","[R[RAbB]]"));
  rules.add(new LRule("b","[D[DaAb]]"));
  rules.add(new LRule("B","[U[UaAB]]"));
  rules.add(new LRule("U","UU"));
  rules.add(new LRule("D","DD"));
  rules.add(new LRule("L","LL"));
  rules.add(new LRule("R","RR"));
  String next = "aAbB";
  for (int i = 0;i < num;++i) next = NextL(next,rules);
  println(next);
  FreeGroup free = new FreeGroup();
  translate(width / 2, height / 2);
  scale(.95);
  noLoop();
  DrawL(next,free,1);
}

int num = 0;
void setup() {

  background(255);
  size(1000,1000);

}

void mouseClicked() {
 seed++;
 loop();
}

void keyPressed() {
 num++;
 loop(); 
}

void draw() {
 //ang = (int)map(mouseX,0,width,-100,100);
 ang = 90;
 background(255);
 DrawCrazyTree(5);
 //DrawFree(8);
}


