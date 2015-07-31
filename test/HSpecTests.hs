module Main where
 
import qualified BF
import Test.Hspec
 
main :: IO ()
main = hspec $ do
 
  --describe "Validate haqify function" $ do
  --  it "haqify is supposed to prefix Haq! to things" $ do
  --    haqify "me" `shouldBe` "Haq! me"

  describe "Eval +++." $ do
    it "should work" $ do
      r <- BF.eval "+++." [] $ replicate 100 0
      r `shouldBe` ()