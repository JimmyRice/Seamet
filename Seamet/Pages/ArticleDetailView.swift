//
//  ArticleDetailView.swift
//  Seamet
//
//  Created by Jimmy on 5/13/22.
//

import SwiftUI

struct ArticleDetailView: View {
    var articleId: Int = 9
    @State private var article: Article = Article(id: 9, title: "反对", createdDate: "2022-04-21T12:16:00", tags: ["文章"], content: "  “哎，你们听说了吗？”\n\n  “听说什么？”\n\n   “一战结束了，欧洲那边平静下来了，现在正在开会呢。要对战败国惩罚，其中最大的惩罚对象就是德国。”\n\n   “哦，这样。”\n\n   “你怎么这样啊，我说，紫川，别倒腾你那个论文了。这不比论文有意思？”李德辉说道。\n\n   “下周就要交了，你写完了我还没写完呢。不过这确实是一件好事，这样山东半岛应该能回归到国家了。”\n\n   “是啊，所以才说有意思。”李德辉看了一眼表说道，“哎呀！约会要迟到了，我先走了紫川。”说完李德辉匆匆忙忙跑了出去。\n\n张紫川也看了一眼表，说道“中午12点了啊，我也该去吃饭了。”之后便穿上长衣，走出了宿舍，在学校门口的一家面铺坐了下来。\n\n“老板来一碗鸡汤刀削面”“好嘞，先生您稍等！”\n\n这时，跑过来一个报童，大喊道“号外！号外！巴黎和会上未归还山东半岛！号外！号外！巴黎和会上未归还山东半岛！”，听到这个消息许多人把那个报童叫住，买他的一份报纸。张紫川也是其中一个，他拿到这个报纸后看到了头版新闻，内容中一行字格外明显：“将山东半岛的德国租界划给日本。”看到这，张紫川的气不打一处来，他连吃面的心情都没有直接回到了学校。其实这样做也没有错，日本也是战胜国理应获得一些利益，但是张紫川哪管这些，他只知道中华民国也是战胜国，为什么没有获得相应的利益呢！张紫川越想越生气，气冲冲的走进宿舍楼，前脚刚踏进门，后面就有人叫住了他\n\n“紫川！”\n\n他回头看过去，是李德辉，问他\n\n“你不是去约会了吗，怎么回来了。”\n\n他笑了笑说道“看到那则新闻，哪还有心情约会。看你这个样子应该知道我说的是哪个新闻吧。”\n\n“那群帝国主义的败类！只想着自己的利益，从来没有考虑过中国！太痛心了！”\n\n“清华大学的学生已经开始游行了，不然我们也加入吧！”\n\n“好！”\n\n随即他们动身，加入到了学生游行的行列，在长安街，在天安门大喊“拒绝在巴黎合约上签字！不能纵容帝国主义！”\n\n….\n\n最后的结果大家应该都知道了，这就是当时五四运动的写景，袁世凯出人逮捕学生，但最后都放出来了。希望我们现在的学生也能像当时一样拥有反抗的精神，不能让别人随意摆弄自己！\n", author: 1, slug: "opposite", category: 3)
    @State private var isLoading: Bool = true
    
    var body: some View {
        ScrollView {
            if !isLoading {
                VStack(alignment: .leading, spacing: 20) {
                    ArticleDetailHeader(articleTitle: article.title, articleCreatedDate: article.createdDate, articleTags: article.tags!)
                    ArticleDetailBody(articleContent: article.content!)
                        .padding(.top, 0)
                }
            } else {
                ProgressView()
                    .onAppear {
                        onAppear()
                    }
            }
        }
        .padding(.vertical, 0)
        .padding(.leading, 10)
        .padding(.top, 0)
    }
    
    func onAppear() {
        Task {
            guard let article = try? await ArticleProvider.getArticle(id: articleId) else {
                fatalError()
            }
            
            self.article = article
            self.isLoading = false
        }
    }
}

struct ArticleDetailView_Previews: PreviewProvider {
    static private let articleId = 9
    
    static var previews: some View {
        ArticleDetailView(articleId: 9)
    }
}
