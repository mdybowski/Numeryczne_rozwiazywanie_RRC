function result = F(v, w)
result = fu(v).*(warunek(v, w) >= 0) + fu(w).*(warunek(v, w) < 0);
end