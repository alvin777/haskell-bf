module Main where
 
import qualified BF
import Test.Hspec
 
main :: IO ()
main = hspec $ do
 
  describe "Check simple cases" $ do
    it "returns 3" $ do
      BF.pureEval "+++++++++++++++++++++++++++++++++++++++++++++++++++." [] `shouldBe` "3"

    it "returns 321" $ do
      BF.pureEval "+++++++++++++++++++++++++++++++++++++++++++++++++++>+++[<.->-]" [] `shouldBe` "321"

    it "returns Hello World!" $ do
      BF.pureEval "++++++++[>++++[>++>+++>+++>+<<<<-]>+>+>->>+[<]<-]>>.>---.+++++++..+++.>>.<-.<.+++.------.--------.>>+.>++." [] `shouldBe` "Hello World!\n"

    it "cats input" $ do
      BF.pureEval ",[.,]" "should copy this\0" `shouldBe` "should copy this"
