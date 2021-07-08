defmodule PrivateTest do
  use ExUnit.Case

  describe "in test mode" do
    defmodule One do
      use Private
      
      def a(), do: nil
      
      private do
        def b(_a), do: nil
        defp c(_a, _b), do: nil
      end
      
      def  d(), do: e()
      defp e(), do: d()

      @publics Module.definitions_in(__MODULE__, :def) |> Enum.sort
      def publics, do: @publics

      @privates Module.definitions_in(__MODULE__, :defp) |> Enum.sort
      def privates, do: @privates
    end
    
    test "module has all private functions public" do
      assert One.publics  == [ a: 0, b: 1, c: 2, d: 0 ]
      assert One.privates == [ e: 0 ]
    end
  end

  describe "in prod mode" do
    defmodule Two do
      use Private
      
      def a(), do: nil
      
      private(:prod) do
        def b(_a), do: nil
        defp c(_a, _b), do: nil
      end
      
      def  d(), do: e() + b(1)
      defp e(), do: d() + c(1,2)

      @publics Module.definitions_in(__MODULE__, :def) |> Enum.sort
      def publics, do: @publics

      @privates Module.definitions_in(__MODULE__, :defp) |> Enum.sort
      def privates, do: @privates
    end
    
    test "the private functions are private" do
      assert Two.publics  == [ a: 0, d: 0 ]
      assert Two.privates == [ b: 1, c: 2, e: 0 ]
    end
  end

  describe "in dev mode" do
    defmodule Three do
      use Private
      
      def a(), do: nil
      
      private(:dev) do
        def b(_a), do: nil
        defp c(_a, _b), do: nil
      end
      
      def  d(), do: e()
      defp e(), do: d()

      @publics Module.definitions_in(__MODULE__, :def) |> Enum.sort
      def publics, do: @publics

      @privates Module.definitions_in(__MODULE__, :defp) |> Enum.sort
      def privates, do: @privates
    end
    
    test "module has all private functions public" do
      assert Three.publics  == [ a: 0, b: 1, c: 2, d: 0 ]
      assert Three.privates == [ e: 0 ]
    end
  end
end
